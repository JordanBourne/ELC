import React, { ReactNode } from 'react';
import Container from '@mui/material/Container';
import Nav from './Nav'

type OwnProps = {
  children: ReactNode
}


export const PageContainer = ({ children }: OwnProps) => {
  return (
    <div>
      <Nav />
      <Container sx={{padding: '20px'}}>
        {children}
      </Container>
    </div>
  );
}

