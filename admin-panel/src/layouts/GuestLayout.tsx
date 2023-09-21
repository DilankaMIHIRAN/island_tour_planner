import { FC, useEffect } from 'react';
import { Col, Grid, Row } from 'antd';
import { Navigate, Route, Routes, useNavigate } from 'react-router-dom';
import Login from '../pages/auth/login';
import { auth, onAuthStateChanged } from '../service/firebase';

const GuestLayout: FC = () => {

  const { useBreakpoint } = Grid;
  const screens = useBreakpoint();
  const navigate = useNavigate();

  // check if user already logged
  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
      if (user) {
        navigate('/admin/score-board');
      } else {
        navigate('/auth');
      }
    });
  }, []);

  return (
    <Row align="middle" justify="center">
      {!screens.xs &&
        <Col xl={12} lg={12} sm={24} xs={24} style={{ display: 'flex', height: '100vh' }}>
          <img src={'https://sandinmysuitcase.com/wp-content/uploads/2021/10/Take-the-Train.jpg'}
            style={{ width: '100%' }}
            alt="" />
        </Col>
      }

      <Col xl={12} lg={12} sm={24} xs={24}>
        <Routes>
          <Route path={'/'} element={<Navigate to={'/auth/login'} replace />} />
          <Route path={'/login'} element={<Login />} />
        </Routes>
      </Col>
    </Row>
  )
}

export default GuestLayout