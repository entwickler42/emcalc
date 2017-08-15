#ifndef EMATHLISTMODEL_H
#define EMATHLISTMODEL_H

#include <QAbstractListModel>

#include <QMetaObject>

#include <QMap>
#include <QList>


#define FREQUENCY  0
#define GAIN       1
#define IMPEDANCE  2

struct emath_data{
	double value;
	const struct emsi_entry* scale;
	const struct emu_entry* unit;
};

class EmathListModel : 
        public QAbstractListModel
{
    Q_OBJECT	
	
public:
    explicit EmathListModel(QObject *parent = 0);
	virtual ~EmathListModel();
	
	int columnCount(const QModelIndex &parent) const;
    int rowCount(const QModelIndex &parent) const;
	
	Qt::ItemFlags flags( const QModelIndex & index ) const;
	
	QVariant data(const QModelIndex &index, int role) const;	
	bool setData ( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole );
	
	qreal frequency() const
	{ return m_data.at(FREQUENCY).value; }
	
	qreal gain() const
	{ return m_data.at(GAIN).value; }
	
	qreal impedance() const
	{ return m_data.at(IMPEDANCE).value; }
	
public slots:
	void setData(int index, const QVariant& value);
	void recalculate(int sourceIndex);
	
private:
	QList<emath_data> m_data;	
};

#endif // EMATHLISTMODEL_H
