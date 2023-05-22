import * as React from 'react';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';

import { PageContainer } from "../components/PageContainer"
import { AccountForm } from '../components/AccountForm'
import apiClient from '../apiClient'
import { useUser } from '../hooks/useUser';

export const SignIn = () => {
  const { handleLogin } = useUser();
  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    apiClient.post('/api/sessions', {
      session: {
        email: data.get('email'),
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
        extraAction={(
          <Grid container>
            <Grid item>
              <Link href="/create_account" variant="body2">
                {"Don't have an account? Sign Up"}
              </Link>
            </Grid>
          </Grid>
        )}
        actionName="Sign In"
      />
    </PageContainer>
  );
}