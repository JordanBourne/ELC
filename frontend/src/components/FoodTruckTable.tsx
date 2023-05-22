import { useNavigate } from 'react-router-dom'

import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

export type FoodTruck = {
  address: string,
  applicant: string,
  approved: string,
  block: string,
  blocklot: string,
  cnn: number,
  dayshours: string,
  expiration_date: string,
  facility_type: string,
  fire_prevention_districs: number,
  food_items: string,
  id: number,
  latitude: number,
  location: string,
  locationId: string,
  location_description: string,
  longitude: number,
  lot: string,
  neighborhoods: number,
  noi_sent: string,
  permit: string,
  police_districts: number,
  prior_permit: boolean,
  received: string,
  schedule: string,
  status: string,
  supervisor_districts: number,
  x: number,
  y: number,
  zipcodes: number,
}

type OwnProps = {
  foodTrucks: FoodTruck[]
}

export const FoodTruckTable = ({ foodTrucks }: OwnProps) => {
  const navigate = useNavigate();

  return (
    <TableContainer component={Paper}>
      <Table sx={{ minWidth: 650 }} size="small" aria-label="food truck table">
        <TableHead>
          <TableRow>
            <TableCell sx={{ fontWeight: "bold" }}>Food Truck Name</TableCell>
            <TableCell sx={{ fontWeight: "bold" }}>Hours</TableCell>
            <TableCell sx={{ fontWeight: "bold" }}>Food Items</TableCell>
            <TableCell sx={{ fontWeight: "bold" }}>Address</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {foodTrucks.map((foodTruck) => (
            <TableRow
              key={foodTruck.id}
              sx={{ 
                '&:last-child td, &:last-child th': { border: 0 },
                cursor: 'pointer'
              }}
              onClick={() => navigate(`/food_truck/${foodTruck.id}`)}
            >
              <TableCell component="th" scope="row">
                {foodTruck.applicant}
              </TableCell>
              <TableCell>{foodTruck.dayshours}</TableCell>
              <TableCell>{foodTruck.food_items}</TableCell>
              <TableCell>{foodTruck.address}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  )
}

