import React, { FC, useEffect, useState } from 'react';
import { Card, Col, Row, Table, Image } from 'antd';
import { collection, onSnapshot, query } from 'firebase/firestore';
import { firestore } from '../../../service/firebase';

const Hotels: FC = () => {

    const [isLoading, setLoading] = useState<boolean>(false);
    const [hotels, setHotels] = useState<any[]>([]);

    const columns = [
        {
            title: 'Logo',
            dataIndex: 'logo',
            key: 'logo',
            render: (text: string, record: any) => <Image src={text} width={100} />
        },
        {
            title: 'Hotel Name',
            dataIndex: 'hotelName',
            key: 'hotelName',
        },
        {
            title: 'Manager Name',
            dataIndex: 'managerName',
            key: 'managerName',
        },
        {
            title: 'Phone',
            dataIndex: 'phoneNumber',
            key: 'phoneNumber',
        },
        {
            title: 'Bio',
            dataIndex: 'bio',
            key: 'bio',
            width: 400,
        },
    ];

    useEffect(() => {
        let unmounted = false;
        setLoading(true);
    
        const unsubscribe = onSnapshot(query(collection(firestore, 'hotels')), (querySnapshot) => {
          if (!unmounted) {
            setHotels([]);
            querySnapshot.forEach((doc) => {
                setHotels((prev) => [...prev, {
                id: doc.id,
                hotelName: doc.data().hotelName,
                managerName: doc.data().managerName,
                phoneNumber: doc.data().phoneNumber,
                bio: doc.data().bio,
                logo: doc.data().logo,
              }])
            });
            setLoading(false);
          }
        }, (error) => {
          console.error(error);
        });
    
        return () => {
          unmounted = true;
          unsubscribe();
        }
      }, []);

    return (
        <div className="tabled">
            <Row gutter={[24, 16]} style={{ marginTop: 20 }}>
                <Col
                    xs={24}
                    xl={24}
                >
                    <Card
                        bordered={false}
                        className="criclebox tablespace"
                        title="Hotels"
                    >
                        <div className="table-responsive">
                            <Table
                                columns={columns}
                                dataSource={hotels}
                                loading={{
                                    spinning: isLoading,
                                    tip: "Loading"
                                }}
                            />
                        </div>
                    </Card>
                </Col>
            </Row>
        </div>
    )
}

export default Hotels