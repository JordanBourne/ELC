import { useNavigate } from 'react-router-dom';

export const useUser = () => {
  const navigate = useNavigate()
  const jwt = localStorage.getItem('jwt')
  const logout = () => {
    localStorage.setItem('jwt', '')
    navigate('/')
  }
  const handleLogin = (token: string) => {
    localStorage.setItem('jwt', token);
    navigate('/');
  }

  return {
    isLoggedIn: !!jwt,
    logout,
    handleLogin
  }
}