import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import AdminLayout from './layouts/AdminLayout';
import GuestLayout from './layouts/GuestLayout';
import NotFound from './pages/NotFound';

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Routes>
        <Route path={'/'} element={<Navigate to={'/auth/login'} replace />} />
          <Route path={"/auth/*"} element={<GuestLayout />} />
          <Route path={"/admin/*"} element={<AdminLayout />} />
          <Route path='*' element={<NotFound />} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
