import { Suspense } from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import reportWebVitals from './reportWebVitals';
import { persistStore } from 'redux-persist';
import { Provider } from 'react-redux';
import { ConfigProvider, Spin, theme } from 'antd';
import { PersistGate } from 'redux-persist/integration/react';
import store from './store';
import './index.css';

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
let persistor = persistStore(store);

root.render(
  <Suspense fallback={<Spin />}>
    <ConfigProvider
      direction={'ltr'}
      theme={{
        algorithm: theme.defaultAlgorithm,
        token: {
          colorPrimary: '#FF7900',
          colorBgContainer: '#ffff'
        },
      }}
    >
      <Provider store={store}>
        <PersistGate loading={null} persistor={persistor}>
          <App />
        </PersistGate>
      </Provider>
    </ConfigProvider>
  </Suspense>
);

reportWebVitals();
