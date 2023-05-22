import * as React from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import { useNavigate } from 'react-router-dom';
import { useUser } from '../hooks/useUser';

type PageNav = {
  title: string,
  location: string,
  requiresAuth: boolean
}

const pages: PageNav[] = [
  {
    title: "All Food Trucks",
    location: "/",
    requiresAuth: false
  },
  {
    title: "My Food Trucks",
    location: "/rated",
    requiresAuth: true
  },
  {
    title: "Suggest A Truck",
    location: "/suggestion",
    requiresAuth: true
  },
]

export default function Nav() {
  const { isLoggedIn, logout } = useUser();
  const navigate = useNavigate();
  const handleSignInClick = () => navigate('/signin');
  const handleHeaderClick = () => navigate('/');

  return (
    <Box sx={{ flexGrow: 1 }}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1, cursor: "pointer" }} onClick={handleHeaderClick}>
            FoodTruckBrowser
          </Typography>
          {pages
            .filter(page => isLoggedIn || !page.requiresAuth)
            .map((page) => (
              <Button
                key={page.title}
                onClick={() => navigate(page.location)}
                sx={{ my: 2, color: 'white', display: 'block' }}
              >
                {page.title}
              </Button>
            ))}
          {isLoggedIn && <Button color="inherit" onClick={logout}>Logout</Button>}
          {!isLoggedIn && <Button color="inherit" onClick={handleSignInClick}>Sign In</Button>}
        </Toolbar>
      </AppBar>
    </Box>
  );
}