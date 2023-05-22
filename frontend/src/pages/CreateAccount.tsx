import * as React from 'react';

import { PageContainer } from '../components/PageContainer';
import { AccountForm } from '../components/AccountForm';
import apiClient from '../apiClient';
import { useUser } from '../hooks/useUser';

export const CreateAccount = () => {
  const { handleLogin } = useUser();
  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    apiClient.post('/api/user', {
      user: {
        email: data.get('email'),
        name: data.get('email'),
        password: data.get('password'),
      }
    }).then(res => {
      handleLogin(res.data.token);
    });
  };

  return (
    <PageContainer>
      <AccountForm
        handleSubmit={handleSubmit}
        actionName="Create Account"
      />
    </PageContainer>
  );
}