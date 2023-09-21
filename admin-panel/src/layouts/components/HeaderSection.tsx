import { FC } from 'react'
import { Layout, Grid, Menu, MenuProps, Space, Dropdown, Avatar } from 'antd';
import { Link, useNavigate } from 'react-router-dom';
import { DownOutlined, UserOutlined } from '@ant-design/icons';
import { notify } from '../../utils/notify';
import { auth, signOut } from '../../service/firebase';

const HeaderSection: FC = () => {

    const { Header } = Layout;
    const { useBreakpoint } = Grid;
    const screens = useBreakpoint();
    const navigate = useNavigate();

    const items: MenuProps['items'] = [
        {
            key: '1',
            label: (
                <a onClick={() => logout()}>
                    Logout
                </a>
            ),
        }
    ];

    const logout = () => {
        signOut(auth).then(() => {
            navigate('/auth/login');
        }).catch((error) => {
            notify('error', 'Error', error.message);
        });
    };

    return (
        <Header
            className="site-layout-background"
            style={{
                padding: 0,
                background: '#fff',
                fontSize: '20px',
                position: 'sticky',
                top: 0,
                zIndex: 13
            }}>
            <Menu
                style={{ display: 'block' }}
                theme="light"
                mode="horizontal"
            >
                {!screens.xs &&
                    <Menu.Item key='home'>
                        <Link to={'/admin/score-board'}>Home</Link>
                    </Menu.Item>
                }

                <Dropdown menu={{ items }}>
                    <Space
                        align="end"
                        style={{ float: 'right', marginRight: '20px', cursor: 'pointer' }}
                    >
                        <Avatar shape="square" icon={<UserOutlined />} />
                        Hi{!screens.xs && (auth.currentUser?.displayName ?? "User")}
                        <DownOutlined />
                    </Space>
                </Dropdown>

            </Menu>
        </Header>
    )
}

export default HeaderSection;