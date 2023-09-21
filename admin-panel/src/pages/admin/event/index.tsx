import { Button, Card, Col, Image, Popconfirm, Row, Space, Table, Tooltip } from 'antd'
import React, { FC, useEffect, useState } from 'react'
import { collection, deleteDoc, doc, onSnapshot, query } from 'firebase/firestore';
import { firestore } from '../../../service/firebase';
import { useNavigate } from 'react-router-dom';
import { Trash } from 'iconsax-react';
import { notify } from '../../../utils/notify';

const Events: FC = () => {

  const navigate = useNavigate();
  const [events, setEvents] = useState<any[]>([]);
  const [isLoading, setLoading] = useState<boolean>(false);

  const columns = [
    {
      title: 'Image',
      dataIndex: 'image',
      key: 'image',
      render: (text: string, record: any) => <Image src={text} width={100} />
    },
    {
      title: 'Name',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: 'Date',
      dataIndex: 'date',
      key: 'date',
    },
    {
      title: 'Ticket Price',
      dataIndex: 'ticketPrice',
      key: 'ticketPrice',
      render: (text: string, record: any) => {
        return "Rs." + text;
      }
    },
    {
      title: 'Action',
      key: 'action',
      render: (text: string, record: any) => {
        return (
          <Space size={5}>
            <Tooltip placement="top" title="Delete" style={{ cursor: 'pointer' }}>
              <Popconfirm
                title="Are you sure to delete this event ?"
                onConfirm={() => deleteEvent(record.id)}
                okText="Yes"
                cancelText="Cancel"
              >
                <Button
                  icon={<Trash size={20} style={{ color: '#FF3200' }} />}
                  style={{ padding: "4px", borderColor: '#FF3200' }}>
                </Button>
              </Popconfirm>
            </Tooltip>
          </Space >
        )
      }
    }
  ];

  const deleteEvent = async (eventId: string) => {
    deleteDoc(doc(firestore, 'events', eventId)).then((res: any) => {
      notify('success', 'Success', 'Event successfully deleted.');
    });
  }

  useEffect(() => {
    let unmounted = false;
    setLoading(true);

    const unsubscribe = onSnapshot(query(collection(firestore, 'events')), (querySnapshot) => {
      if (!unmounted) {
        setEvents([]);
        querySnapshot.forEach((doc) => {
          setEvents((prev) => [...prev, {
            id: doc.id,
            name: doc.data().name,
            location: doc.data().location,
            ticketPrice: doc.data().ticketPrice,
            image: doc.data().image,
            date: doc.data().date,
            description: doc.data().description,
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

  const onCreate = () => navigate('/admin/events/create')

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
            title="Events"
            extra={
              <>
                <Button onClick={onCreate}>Create</Button>
              </>
            }
          >
            <div className="table-responsive">
              <Table
                columns={columns}
                dataSource={events}
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

export default Events