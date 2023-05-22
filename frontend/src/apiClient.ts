// apiClient.ts
import axios, { AxiosInstance } from 'axios';

const apiClient: AxiosInstance = axios.create({
  baseURL: 'http://localhost:4000', // Your API base URL
});

// Request interceptor for API calls
apiClient.interceptors.request.use(
  async (config) => {
    const token = localStorage.getItem('jwt');
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
      config.headers['Accept'] = 'application/json';
      config.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    }
    return config;
  },
  (error) => {
    Promise.reject(error)
  }
);

export default apiClient;
