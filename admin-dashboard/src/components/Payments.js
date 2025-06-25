import React, { useState, useEffect } from 'react';
import axios from 'axios';
import {
  Box,
  Typography,
  CircularProgress,
  Snackbar,
  Alert,
} from '@mui/material';
import { DataGrid } from '@mui/x-data-grid';

export default function Payments() {
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [snackbar, setSnackbar] = useState({ open: false, message: '', severity: 'success' });

  useEffect(() => {
    fetchPayments();
  }, []);

  const fetchPayments = async () => {
    setLoading(true);
    setError('');
    try {
      const res = await axios.get('/api/v1/admin/payments');
      setRows(res.data);
    } catch (err) {
      setError('Failed to load payments');
    } finally {
      setLoading(false);
    }
  };

  const columns = [
    { field: 'id', headerName: 'ID', width: 90 },
    { field: 'user', headerName: 'User', flex: 1, minWidth: 160, valueGetter: (params) => params.row.user ? `${params.row.user.firstName} ${params.row.user.lastName}` : '' },
    { field: 'amount', headerName: 'Amount', flex: 1, minWidth: 120, valueGetter: (params) => `$${params.row.amount}` },
    { field: 'status', headerName: 'Status', flex: 1, minWidth: 120 },
    { field: 'method', headerName: 'Method', flex: 1, minWidth: 120 },
    { field: 'createdAt', headerName: 'Date', flex: 1, minWidth: 140, valueGetter: (params) => params.row.createdAt ? new Date(params.row.createdAt).toLocaleDateString() : '' },
  ];

  return (
    <Box>
      <Box display="flex" alignItems="center" justifyContent="space-between" mb={3}>
        <Typography variant="h4" fontWeight={700}>
          Payments
        </Typography>
      </Box>
      <Box sx={{ height: 480, bgcolor: 'white', borderRadius: 2, boxShadow: 2, p: 2 }}>
        {loading ? (
          <Box display="flex" alignItems="center" justifyContent="center" height="100%">
            <CircularProgress />
          </Box>
        ) : error ? (
          <Alert severity="error">{error}</Alert>
        ) : (
          <DataGrid
            rows={rows}
            columns={columns}
            pageSize={7}
            rowsPerPageOptions={[7, 15, 30]}
            disableSelectionOnClick
            sx={{
              '& .MuiDataGrid-row:hover': {
                bgcolor: 'grey.100',
                transition: 'background 0.2s',
              },
              '& .MuiDataGrid-cell': {
                fontSize: 16,
              },
              '& .MuiDataGrid-columnHeaders': {
                bgcolor: 'grey.50',
                fontWeight: 700,
                fontSize: 16,
              },
            }}
          />
        )}
      </Box>
      <Snackbar
        open={snackbar.open}
        autoHideDuration={3000}
        onClose={() => setSnackbar({ ...snackbar, open: false })}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
      >
        <Alert severity={snackbar.severity} sx={{ width: '100%' }}>
          {snackbar.message}
        </Alert>
      </Snackbar>
    </Box>
  );
} 