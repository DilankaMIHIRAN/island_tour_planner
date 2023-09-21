import { Typography, Form, Spin, Col, Input, Space, Button } from 'antd';
import React from 'react';
import { FC, useState } from 'react'
import { useNavigate } from 'react-router-dom';
import { auth, signInWithEmailAndPassword } from '../../service/firebase';
import { notify } from '../../utils/notify';

const Login: FC = () => {

  const { Title } = Typography;
  const [form] = Form.useForm();
  const navigate = useNavigate();
  const [isLoading, setLoading] = useState<boolean>(false);

  const onFinish = async (values: any) => {
    setLoading(true);
    await signInWithEmailAndPassword(auth, values.email, values.password).then((userCredential) => {
      const user = userCredential.user;
      if (user) {
        navigate('/admin/events');
      }
    }).catch((error) => {
      notify('error', 'Error', error.message);
    });
    setLoading(false);
  };

  return (
    <React.Fragment>
      <Col lg={16} xs={24} sm={24} xl={24} offset={4}>
        <Space direction="vertical" wrap>
          <Title level={3} >
            Hello, there !
          </Title>

          <Title level={5}>
            Please login to continue
          </Title>
        </Space>
      </Col>

      <Spin tip="Loading" size="small" spinning={isLoading}>
        <Form form={form} onFinish={onFinish} layout="vertical">
          <Col lg={16} offset={4}>
            <Form.Item
              name="email"
              label="E-mail"
              rules={[
                {
                  required: true,
                  message: 'E-mail is required'
                }
              ]}
            >
              <Input size="large" placeholder='E-mail' />
            </Form.Item>
          </Col>

          <Col lg={16} offset={4}>
            <Form.Item
              name="password"
              label="Password"
              rules={[
                {
                  required: true,
                  message: 'Password is required'
                }
              ]}
            >
              <Input.Password size="large" placeholder='Password' />
            </Form.Item>
          </Col>

          <Col lg={16} offset={4}>
            <Button htmlType="submit" type="primary" size="large">
              Login
            </Button>
          </Col>
        </Form>
      </Spin>
    </React.Fragment>
  )
}

export default Login