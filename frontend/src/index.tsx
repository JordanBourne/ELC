import React from 'react';
import ReactDOM from 'react-dom/client';
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";

import './index.css';
import { CreateAccount } from './pages/CreateAccount'
import { FoodTruckDetail } from './pages/FoodTruckDetail'
import { Home } from './pages/Home';
import { SignIn } from './pages/SignIn'
import { TruckSuggestion } from './pages/TruckSuggestion'
import { RatedFoodTrucks } from './pages/RatedFoodTrucks'

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);

const router = createBrowserRouter([
  {
    path: "/",
    element: <Home />,
  },
  {
    path: "/signin",
    element: <SignIn />,
  },
  {
    path: "/create_account",
    element: <CreateAccount />,
  },
  {
    path: "/rated",
    element: <RatedFoodTrucks />,
  },
  {
    path: "/food_truck/:id",
    element: <FoodTruckDetail />,
  },
  {
    path: "/suggestion",
    element: <TruckSuggestion />,
  },
]);

root.render(
  <RouterProvider router={router} />
);
