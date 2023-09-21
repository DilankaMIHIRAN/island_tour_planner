import { Grid, Layout } from 'antd';
import { FC, useEffect } from 'react'
import { Route, Routes, useLocation, useNavigate } from 'react-router-dom';
import Login from '../pages/auth/login';
import SidebarSection from './components/SidebarSection';
import HeaderSection from './components/HeaderSection';
import admin from '../routes/admin';
import { auth, onAuthStateChanged } from '../service/firebase';
import CreateEvent from '../pages/admin/event/create';

const AdminLayout: FC = () => {

  const { useBreakpoint } = Grid;
  const { Content, Footer } = Layout;
  const screens = useBreakpoint();
  const navigate = useNavigate();
  const location = useLocation();

  const currentYear = new Date().getFullYear();

  const getRoutes = (routes: any[]) => {
    return routes.map((prop: any) => {
      return <Route path={prop.path} element={prop.component} />
    })
  };

  //check if user already logged
  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
        if (user) {
            navigate(location.pathname);
        } else {
            navigate('/auth');
        }
    });
}, []);

  return (
    <Layout hasSider style={{ minHeight: '100vh' }}>

      <SidebarSection />

      <Layout className="site-layout" style={{ marginLeft: (screens.sm && !screens.lg) ? 80 : (screens.lg || screens.md || screens.xl) ? 200 : (screens.xs) ? 80 : 0 }}>

        <HeaderSection />

        <Content
          style={{
            margin: '20px 16px',
            padding: 12,
            minHeight: 280
          }}
        >
          <div className="site-layout-background" style={{ marginTop: '10px', minHeight: 360 }}>
            <Routes>
              <Route path={'/login'} element={<Login />} />
              {getRoutes(admin)}
              <Route path={'/events/create'} element={<CreateEvent/>}/>
            </Routes>
          </div>
        </Content>

        <Footer style={{ textAlign: 'center' }}>
          <p>Copyright &copy; {currentYear} I Tour Planner</p>
        </Footer>

      </Layout>
    </Layout>
  )
}

export default AdminLayout