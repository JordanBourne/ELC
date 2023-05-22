import { useEffect, useState } from "react"
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';

import apiClient from "../apiClient"
import { FoodTruck, FoodTruckTable } from "../components/FoodTruckTable"
import { PageContainer } from "../components/PageContainer"
import { UnauthenticatedView } from "../components/UnauthenticatedView"
import { useUser } from "../hooks/useUser"

export const TruckSuggestion = () => {
  const { isLoggedIn } = useUser()
  const [unratedTruck, setUnratedTruck] = useState<FoodTruck>()
  const [ratedTruck, setRatedTruck] = useState<FoodTruck>()

  const fetchRandomUnrated = () => {
    apiClient.get('/api/food_truck/random').then(response => {
      setUnratedTruck(response.data.data);
    })
  }

  const fetchRandomRated = () => {
    apiClient.get('/api/ratings/random').then(response => {
      setRatedTruck(response.data.data);
    })
  }

  useEffect(() => {
    if (isLoggedIn) {
      fetchRandomUnrated()
      fetchRandomRated()
    }
  }, [isLoggedIn])

  const refreshSuggestions = () => {
    fetchRandomUnrated()
    fetchRandomRated()
  }

  const renderAuthenticatedView = () => {
    return (
      <>
        {unratedTruck && (
          <>
            <Typography variant="h6" sx={{marginTop: '25px'}}>A New Experience</Typography>
            <FoodTruckTable foodTrucks={[unratedTruck]} />
          </>
        )}
        {ratedTruck && (
          <>
            <Typography variant="h6" sx={{marginTop: '25px'}}>A Repeat Experience</Typography>
            <FoodTruckTable foodTrucks={[ratedTruck]} />
          </>
        )}
        <Button sx={{marginTop: '25px'}} variant="contained" onClick={refreshSuggestions}>Refresh Suggestions</Button>
      </>
    )
  }

  const renderUnauthenticatedView = () => {
    return <UnauthenticatedView />
  }


  return (
    <PageContainer>
      <Typography variant="h4">Food Truck Suggestions</Typography>
      {isLoggedIn && renderAuthenticatedView()}
      {!isLoggedIn && renderUnauthenticatedView()}
    </PageContainer>
  )
}