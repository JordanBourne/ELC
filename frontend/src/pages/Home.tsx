import { useEffect, useState } from 'react'
import apiClient from '../apiClient'

import { FoodTruck, FoodTruckTable } from "../components/FoodTruckTable"
import { PageContainer } from "../components/PageContainer"

export const Home = () => {
  const [foodTrucks, setFoodTrucks] = useState<FoodTruck[]>([]);

  useEffect(() => {
    apiClient.get('/api/food_truck').then(response => {
      setFoodTrucks(response.data.data)
    })
  }, [])

  return (
    <PageContainer>
      <FoodTruckTable foodTrucks={foodTrucks} />
    </PageContainer>
  )
}