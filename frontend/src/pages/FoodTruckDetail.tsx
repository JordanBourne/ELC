import { PageContainer } from "../components/PageContainer"
import { useParams } from 'react-router-dom'
import { useEffect, useState } from "react"
import Typography from '@mui/material/Typography';
import Rating from '@mui/material/Rating';

import apiClient from "../apiClient"
import { FoodTruck } from "../components/FoodTruckTable"
import { TextDataField } from "../components/TextDataField"
import { useUser } from "../hooks/useUser"

export const FoodTruckDetail = () => {
  const { id } = useParams()
  const { isLoggedIn } = useUser()
  const [ratingLoading, setRatingLoading] = useState(true);
  const [foodTruck, setFoodTruck] = useState<FoodTruck>();
  const [ratingId, setRatingId] = useState<number | undefined>();
  const [ratingValue, setRatingValue] = useState<number | undefined>();

  useEffect(() => {
    if (!id) return;

    apiClient.get(`/api/food_truck/${id}`)
      .then(response => {
        setFoodTruck(response.data.data);
      })
  }, [id])

  useEffect(() => {
    if (!isLoggedIn) return;
    
    apiClient.get(`/api/rating?food_truck_id=${id}`)
      .then(response => {
        setRatingId(response.data.data.id);
        setRatingValue(response.data.data.rating);
        setRatingLoading(false);
      }).catch(err => {
        setRatingId(undefined);
        setRatingLoading(false);
      });
  }, [id, isLoggedIn])

  const setFoodTruckRating = (rating: number) => {
    apiClient.post('/api/ratings', {
      rating: {
        rating: rating,
        food_truck_id: id
      }
    }).then(response => {
      setRatingId(response.data.data.id);
    })
  }

  const updateFoodTruckRating = (rating: number) => {
    apiClient.put(`/api/ratings/${ratingId}`, {
      rating: {
        rating: rating,
        food_truck_id: id
      }
    }).then(response => {
      setRatingId(response.data.data.id);
    })
  }

  const handleRatingUpdate = (event: React.SyntheticEvent<Element, Event>, value: number | null) => {
    if (!value) return;

    setRatingValue(value);
    if (ratingId) {
      updateFoodTruckRating(value);
    } else {
      setFoodTruckRating(value);
    }
  }

  return (
    <PageContainer>
      {!foodTruck && <div>Loading...</div>}
      <Typography variant="h4">{foodTruck?.applicant}</Typography>
      <TextDataField label="Address" data={foodTruck?.address || ""}/>
      <TextDataField label="Hours" data={foodTruck?.dayshours || "-"}/>
      <TextDataField label="Menu" data={foodTruck?.food_items || ""}/>
      
      {isLoggedIn && (
        <>
          <Typography variant="h6" sx={{ marginTop: "20px" }}>How would you rate your experience here?</Typography>
          {!ratingLoading && <Rating
            value={ratingValue}
            defaultValue={ratingValue}
            onChange={handleRatingUpdate}
          />}
        </>
      )}
    </PageContainer>
  )
}