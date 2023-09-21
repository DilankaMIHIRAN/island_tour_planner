import moment from 'moment';
import { notify } from '../../../utils/notify';
import { getBase64 } from '../../../utils/common';
import { firestore } from '../../../service/firebase';
import { FC, useState } from 'react'
import { addDoc, collection } from "firebase/firestore";
import { getDownloadURL, getStorage, ref, uploadBytesResumable } from "firebase/storage";
import { Button, Card, Col, DatePicker, Form, Input, Row, Space, Upload, Image, Spin } from 'antd';
import { useNavigate } from 'react-router-dom';

const CreateEvent: FC = () => {

  const [form] = Form.useForm();
  const { TextArea } = Input;
  const navigate = useNavigate();

  const [isLoading, setLoading] = useState<boolean>(false);
  const [previewImage, setPreviewImage] = useState<string>("");

  const onFinish = async (values: any) => {
    setLoading(true);
    const storage = getStorage();
    const storageRef = ref(storage, `/events/${values.image.file.name}`);
    const uploadTask = uploadBytesResumable(storageRef, values.image.file);
    uploadTask.on('state_changed', (snapshot) => {
      const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      console.log('Upload is ' + progress + '% done');
      switch (snapshot.state) {
        case 'paused':
          console.log('Upload is paused');
          break;
        case 'running':
          console.log('Upload is running');
          break;
      }
    },
      (error) => {
        notify('error', 'Error', error.message);
        setLoading(false);
      },
      () => {
        getDownloadURL(uploadTask.snapshot.ref).then(async (downloadURL) => {
          console.log('File available at', downloadURL);
          await addDoc(collection(firestore, 'events'), {
            name: values.name,
            description: values.description,
            ticketPrice: values.ticketPrice,
            location: values.location,
            image: downloadURL,
            date: moment(new Date(values.date)).format('MMMM Do YYYY')
          }).then((res) => {
            if (res) {
              notify('success', 'Success', 'Event successfully created.');
              form.resetFields();
              setLoading(false);
              navigate(-1);
            }
          });
        });
      }
    );


  };

  const handleChange = async (file: any) => {
    if (file.fileList[0]) {
      setPreviewImage(await getBase64(file.fileList[0].originFileObj));
    } else {
      setPreviewImage("");
    }
  };

  return (
    <div>
      <Row gutter={[24, 16]}>
        <Col
          xs={24}
          xl={24}
        >
          <Card
            bordered={false}
            className="criclebox tablespace"
            title="Add Event"
          >
            <Spin tip="Loading" size="small" spinning={isLoading}>
              <Form form={form} layout="vertical" onFinish={onFinish}>
                <Row gutter={16}>

                  <Col xs={24} md={12} span={12}>
                    <Form.Item
                      name="name"
                      label="Event Name"
                      rules={[
                        {
                          required: true,
                          message: 'Event name is required'
                        }
                      ]}
                    >
                      <Input placeholder='Event Name' />
                    </Form.Item>
                  </Col>

                  <Col xs={24} md={12} span={12}>
                    <Form.Item
                      name="date"
                      label="Date"
                      rules={[
                        {
                          required: true,
                          message: 'Date is required'
                        }
                      ]}
                    >
                      <DatePicker style={{ width: '100%' }} />
                    </Form.Item>
                  </Col>

                  <Col xs={24} md={12} span={12}>
                    <Form.Item
                      name="location"
                      label="Location"
                      rules={[
                        {
                          required: true,
                          message: 'Location is required'
                        }
                      ]}
                    >
                      <Input placeholder='Location' />
                    </Form.Item>
                  </Col>

                  <Col xs={24} md={12} span={12}>
                    <Form.Item
                      name="ticketPrice"
                      label="Ticket Price"
                      rules={[
                        {
                          required: true,
                          message: 'Ticket Price is required'
                        }
                      ]}
                    >
                      <Input placeholder='Ticket Price' />
                    </Form.Item>
                  </Col>

                  <Col xs={24} md={12} span={12}>
                    <Form.Item
                      name="description"
                      label="description"
                      rules={[
                        {
                          required: true,
                          message: 'Description is required'
                        }
                      ]}
                    >
                      <TextArea rows={4} placeholder='Description' />
                    </Form.Item>
                  </Col>

                  <Col xs={6} md={12} span={12}>
                    <Form.Item
                      name="image"
                      label="image"
                      rules={[
                        {
                          required: true,
                          message: 'Image is required'
                        }
                      ]}
                    >
                      <Upload
                        accept="image/png, image/jpeg"
                        maxCount={1}
                        multiple={false}
                        onChange={handleChange}
                        beforeUpload={() => false}
                        listType="text"
                        showUploadList={false}
                      >
                        <Button>Click to Upload</Button>
                      </Upload>
                    </Form.Item>
                  </Col>

                  {previewImage && <Col span={6}>
                    <Space style={{ marginBottom: "20px" }}>
                      <Image src={previewImage} width={200} />
                    </Space>
                  </Col>
                  }

                  <Col xs={24} md={24} span={12}>
                    <Button htmlType="submit" type="primary">
                      Create
                    </Button>
                  </Col>

                </Row>
              </Form>
            </Spin>

          </Card>
        </Col>
      </Row>
    </div>
  )
}

export default CreateEvent