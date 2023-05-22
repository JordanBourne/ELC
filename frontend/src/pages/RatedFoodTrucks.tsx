import { useEffect, useState } from 'react'
import Typography from '@mui/material/Typography';

import apiClient from '../apiClient'
import { FoodTruck, FoodTruckTable } from "../components/FoodTruckTable"
import { PageContainer } from "../components/PageContainer"
import { UnauthenticatedView } from '../components/UnauthenticatedView'
import { useUser } from '../hooks/useUser'

type Rating = {
  id: number
  rating: number
  user_id: number
  food_truck_id: number
  food_truck: FoodTruck
}

const parseFoodTrucks: (ratings: Rating[]) => FoodTruck[] = (ratings: Rating[]) => {
  return ratings.map((rating: Rating) => rating.food_truck)
}

export const RatedFoodTrucks = () => {
  const { isLoggedIn } = useUser()
  const [foodTrucks, setFoodTrucks] = useState<FoodTruck[]>([]);

  useEffect(() => {
    if (isLoggedIn) {
      apiClient.get('/api/ratings').then(response => {
        setFoodTrucks(parseFoodTrucks(response.data.data))
      })
    }
  }, [isLoggedIn])

  return (
    <PageContainer>
      <Typography variant="h4">Your Rated Food Trucks</Typography>
      {isLoggedIn && <FoodTruckTable foodTrucks={foodTrucks} />}
      {!isLoggedIn && <UnauthenticatedView />}
    </PageContainer>
  )
}