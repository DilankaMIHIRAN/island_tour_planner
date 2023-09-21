import { Card, Col, Row, Table, Image, Tag, Space } from 'antd'
import { collection, onSnapshot, query } from 'firebase/firestore';
import React, { FC, useEffect, useState } from 'react'
import { firestore } from '../../../service/firebase';

const Cabs: FC = () => {

    const [isLoading, setLoading] = useState<boolean>(false);
    const [tourGuides, setTourGuides] = useState<any[]>([]);

    const columns = [
        {
            title: 'Image',
            dataIndex: 'avatar',
            key: 'avatar',
            render: (text: string, record: any) => <Image src={text} width={100} />
        },
        {
            title: 'Name',
            dataIndex: 'name',
            key: 'name',
        },
        {
            title: 'Phone',
            dataIndex: 'phoneNumber',
            key: 'phoneNumber',
        },
        {
            title: 'E-mail',
            dataIndex: 'email',
            key: 'email',
        },
        {
            title: 'Languages',
            width: '20%',
            render: (text: string, record: any) => {
                return <div style={{ wordWrap: 'break-word', wordBreak: 'break-word' }}>
                  {record.languages.map((language: any) => <Space>
                    <Tag color="processing">{language}</Tag>
                  </Space>)
                  }
                </div>
              },
        },
        {
            title: 'Bio',
            dataIndex: 'bio',
            key: 'bio',
            render: (text: string) => {
                return <div style={{ wordWrap: 'break-word', wordBreak: 'break-word' }}>{text}</div>
              }
        },
    ];

    useEffect(() => {
        let unmounted = false;
        setLoading(true);

        const unsubscribe = onSnapshot(query(collection(firestore, 'cab_drivers')), (querySnapshot) => {
            if (!unmounted) {
                setTourGuides([]);
                querySnapshot.forEach((doc) => {
                    setTourGuides((prev) => [...prev, {
                        id: doc.id,
                        name: doc.data().name,
                        phoneNumber: doc.data().phoneNumber,
                        email: doc.data().email,
                        bio: doc.data().bio,
                        avatar: doc.data().avatar,
                        languages: doc.data().languages,
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
                        title="Cab Drivers"
                    >
                        <div className="table-responsive">
                            <Table
                                columns={columns}
                                dataSource={tourGuides}
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

export default Cabs