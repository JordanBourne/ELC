import React from 'react';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';

type OwnProps = {
  label: string,
  data: string
}

export const TextDataField = ({ label, data }: OwnProps) => {
  return <Grid container spacing={1}>
    <Grid item xs={2}>
      <Typography sx={{fontWeight: "bold", width: "100px", marginRight: "5px"}}>{label}:</Typography>
    </Grid>
    <Grid item xs={9}>
      <Typography>{data}</Typography>
    </Grid>
  </Grid>
}