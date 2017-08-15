#include "emathlistmodel.h"
#include <QList>
#include <QHash>
#include <emsi.h>
#include <emath.h>


const int UnitNameRole  = Qt::UserRole + 1;
const int UnitValueRole = Qt::UserRole + 2;


EmathListModel::EmathListModel(QObject *parent) :
    QAbstractListModel(parent)
{		
	// named roles are required by QML
	QHash<int,QByteArray> roles = roleNames();
    roles.insert(UnitNameRole, QByteArray("unitName"));
    roles.insert(UnitValueRole, QByteArray("unitValue"));
    setRoleNames(roles);	
	/* prepare data storage; first add user input fields, then
   add emath units by valid quantities */
	const struct emsi_entry* emsi_11 = emsi_find_11();
	// insert user input field	
	double ui_data[] = { 1000.0, 0.0, 50.0 };
	for( int i=0, i_max=sizeof(ui_data)/sizeof(double); i<i_max; i++ ){
		struct emath_data data;
		data.unit  = 0;
		data.scale = emsi_11;
		data.value = ui_data[i];
		m_data.push_back(data);
	}
	// insert units by valid quantity
	int quantity[] = { EMF_POWER, EMF_E };	
	for( int i=0; i<EMU_COUNT; i++ ){
		for( int j=0, j_max=sizeof(quantity)/sizeof(int); j<j_max; j++ ){
			struct emath_data data;						
			if( (data.unit = emu_find(i)) && ( data.unit->quantity & quantity[j]) == quantity[j] ){
				data.value = 0.0;
				data.scale = emsi_11;
				m_data.push_back(data);				
				break;
			}
		}
	}
	recalculate(3);
}

EmathListModel::~EmathListModel()
{}

int EmathListModel::columnCount(const QModelIndex &parent) const
{			
	return 2;
}

int EmathListModel::rowCount(const QModelIndex &parent) const
{
	return m_data.count();
}

Qt::ItemFlags EmathListModel::flags( const QModelIndex & index ) const
{
	return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

QVariant EmathListModel::data(const QModelIndex &index, int role) const
{	
	if( index.row() > m_data.count() -1 )
		return QVariant();
	if( !index.isValid() )
		return QVariant();
	
	const struct emath_data& data = m_data.at(index.row());
	switch( role )
	{	
	
	case UnitValueRole:
		// get value
		return QVariant(QString::number(data.value / data.scale->factor, 'f', 3));
		
	case UnitNameRole:
		// get suffix		
		switch( index.row() )
		{
		case 0: return QVariant(tr("MHz"));
		case 1: return QVariant(tr("dBm"));
		case 2: return QVariant(tr("Ohm"));
		default:								
			return QVariant(QString("%1%2")
			                .arg(QString::fromWCharArray(data.scale->suffix))
			                .arg(QString::fromWCharArray(data.unit->suffix)));
		}
	}
	return QVariant();
}

bool EmathListModel::setData ( const QModelIndex & index, const QVariant & value, int role)
{
	switch( role )
	{
	case UnitValueRole:
		m_data[index.row()].value = value.toDouble() * m_data[index.row()].scale->factor;
		emit dataChanged(index, index);
		recalculate(index.row());
		return true;
	}
	
	return QAbstractListModel::setData(index, value, role);
}

void EmathListModel::setData(int index, const QVariant& value)
{
	setData(EmathListModel::index(index, 0), value, UnitValueRole);
}

void EmathListModel::recalculate(int sourceIndex)
{
	/* select source unit of measurement and default to dBm
 if either frequency, gain or impedance where changed */ 
	struct emath_data& src = m_data[sourceIndex];
	if( !src.unit ) src = m_data.at(3);
	/* calculate results */
	
	qDebug("source unit: %s value %0.16f", 
	       qPrintable(QString::fromWCharArray(src.unit->suffix)),
	       src.value);
	
	for( int i=3; i<m_data.count(); i++ ){
		struct emath_data& dst = m_data[i];
		if( dst.unit == src.unit )
			continue;
		
		emconv(src.value, 
		       src.unit->emu, 
		       &dst.value, 
		       dst.unit->emu, 
		       impedance(),
		       gain(),
		       uint64_t(frequency()) * uint64_t(1000000));
		
		qDebug("destination unit: %s value %0.16f", 
		       qPrintable(QString::fromWCharArray(dst.unit->suffix)),
		       dst.value);
		
		// find unit scaling 
		if( dst.unit->db_type == EM_NOTDB ){
			const struct emsi_entry* scale = emsi_find_scale(dst.value, 10.0);
			if( scale ) dst.scale = scale;
		}
		emit dataChanged(index(i, 0), index(i, 0));
	}
}
