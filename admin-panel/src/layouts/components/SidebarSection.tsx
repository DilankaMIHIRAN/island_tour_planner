import { FC } from 'react'
import { Layout, Menu } from 'antd';
import { Link } from 'react-router-dom';
import admin from '../../routes/admin';

const SidebarSection: FC = () => {

    const { Sider } = Layout;

    const getRoutes = (routes: any[]) => {
        return routes.map((prop: any, index: any) => {
            return (
                <Menu.Item
                    key={index+1}
                    icon={prop.icon}
                >
                    <Link to={`/admin${prop.path}`}>
                        {prop.name}
                    </Link>
                </Menu.Item>
            )
        })
    };

    return (
        <Sider
            breakpoint="lg"
            collapsed={false}
            style={{
                overflow: 'auto',
                height: '100vh',
                position: 'fixed',
                left: 0,
                top: 0,
                bottom: 0,
                zIndex: 2
            }}
        >

            <div className="logo" style={{ height: 55, margin: 16, bottom: 50 }}>
                <a
                    href="/admin/score-board"
                    style={{
                        display: 'flex',
                        justifyContent: 'space-evenly',
                        fontSize: '18px',
                        color: '#fff',
                        alignItems: 'baseline'
                    }}>
                        
             
                    <h3 style={{ width: '200px', fontSize: 18, textAlign: 'center' }}>I Tour Planner</h3>
                    
                </a>
            </div>

            <Menu
                theme="dark"
                mode="inline"
            >
               {getRoutes(admin)}
            </Menu>

        </Sider>
    )
}
export default SidebarSection;