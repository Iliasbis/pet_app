import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useAuth } from '../contexts/AuthContext';
import {
  Box,
  Typography,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  IconButton,
  MenuItem,
  CircularProgress,
  Snackbar,
  Alert,
  Select,
} from '@mui/material';
import { DataGrid } from '@mui/x-data-grid';
import EditIcon from '@mui/icons-material/Edit';
import DeleteIcon from '@mui/icons-material/Delete';

const statusOptions = ['pending', 'confirmed', 'completed', 'cancelled'];

export default function Bookings() {
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [editOpen, setEditOpen] = useState(false);
  const [deleteOpen, setDeleteOpen] = useState(false);
  const [selected, setSelected] = useState(null);
  const [status, setStatus] = useState('pending');
  const [snackbar, setSnackbar] = useState({ open: false, message: '', severity: 'success' });
  const { user, loading: authLoading } = useAuth();

  const fetchAllData = async () => {
    setLoading(true);
    setError('');
    try {
      const bookingsRes = await axios.get('/api/v1/admin/bookings');
      console.log('Bookings API:', bookingsRes.data);
      const bookings = bookingsRes.data || [];
      setRows(bookings);
    } catch (err) {
      setError('Failed to load bookings');
      setRows([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!authLoading && user) {
      fetchAllData();
    }
  }, [user, authLoading]);

  const handleEdit = (row) => {
    setSelected(row);
    setStatus(row.status);
    setEditOpen(true);
  };

  const handleEditSave = async () => {
    try {
      await axios.patch(`/api/v1/bookings/${selected.id}/status`, { status });
      setSnackbar({ open: true, message: 'Booking status updated', severity: 'success' });
      fetchAllData();
    } catch (err) {
      setSnackbar({ open: true, message: 'Failed to update status', severity: 'error' });
    }
    setEditOpen(false);
    setSelected(null);
  };

  const handleDelete = (row) => {
    setSelected(row);
    setDeleteOpen(true);
  };

  const handleDeleteConfirm = async () => {
    try {
      await axios.delete(`/api/v1/bookings/${selected.id}`);
      setSnackbar({ open: true, message: 'Booking deleted', severity: 'success' });
      fetchAllData();
    } catch (err) {
      setSnackbar({ open: true, message: 'Failed to delete booking', severity: 'error' });
    }
    setDeleteOpen(false);
    setSelected(null);
  };

  const columns = [
    { field: 'id', headerName: 'Booking ID', width: 180 },
    { field: 'userName', headerName: 'User Name', flex: 1, minWidth: 140, renderCell: (params) => params.row.user ? `${params.row.user.firstName || ''} ${params.row.user.lastName || ''}` : '' },
    { field: 'userEmail', headerName: 'User Email', flex: 1, minWidth: 180, renderCell: (params) => params.row.user ? params.row.user.email || '' : '' },
    { field: 'userPhone', headerName: 'User Phone', flex: 1, minWidth: 140, renderCell: (params) => params.row.user ? params.row.user.phone || '' : '' },
    { field: 'petName', headerName: 'Pet Name', flex: 1, minWidth: 120, renderCell: (params) => params.row.pet ? params.row.pet.name || '' : '' },
    { field: 'petBreed', headerName: 'Pet Breed', flex: 1, minWidth: 120, renderCell: (params) => params.row.pet ? params.row.pet.breed || '' : '' },
    { field: 'petSize', headerName: 'Pet Size', flex: 1, minWidth: 100, renderCell: (params) => params.row.pet ? params.row.pet.size || '' : '' },
    { field: 'petWeight', headerName: 'Pet Weight', flex: 1, minWidth: 100, renderCell: (params) => params.row.pet ? params.row.pet.weight || '' : '' },
    { field: 'serviceType', headerName: 'Service Type', flex: 1, minWidth: 120, renderCell: (params) => params.row.service ? params.row.service.type || '' : '' },
    { field: 'serviceName', headerName: 'Service Name', flex: 1, minWidth: 120, renderCell: (params) => params.row.service ? params.row.service.name || '' : '' },
    { field: 'serviceDescription', headerName: 'Service Description', flex: 1, minWidth: 180, renderCell: (params) => params.row.service ? params.row.service.description || '' : '' },
    { field: 'type', headerName: 'Booking Type', flex: 1, minWidth: 100 },
    { field: 'status', headerName: 'Status', flex: 1, minWidth: 100 },
    { field: 'totalPrice', headerName: 'Price', flex: 1, minWidth: 100, renderCell: (params) => params.row.totalPrice !== undefined ? `$${Number(params.row.totalPrice).toFixed(2)}` : '' },
    { field: 'needsCrate', headerName: 'Needs Crate', flex: 1, minWidth: 100, renderCell: (params) => params.row.needsCrate ? 'Yes' : 'No' },
    { field: 'needsMedication', headerName: 'Needs Medication', flex: 1, minWidth: 120, renderCell: (params) => params.row.needsMedication ? 'Yes' : 'No' },
    { field: 'isSpecialTime', headerName: 'Special Time', flex: 1, minWidth: 100, renderCell: (params) => params.row.isSpecialTime ? 'Yes' : 'No' },
    { field: 'waitReturnHours', headerName: 'Wait/Return Hours', flex: 1, minWidth: 120 },
    { field: 'specialInstructions', headerName: 'Special Instructions', flex: 1, minWidth: 160 },
    { field: 'adminNotes', headerName: 'Admin Notes', flex: 1, minWidth: 140 },
    { field: 'pickupAddress', headerName: 'Pickup Address', flex: 1, minWidth: 180 },
    { field: 'dropOffAddress', headerName: 'DropOff Address', flex: 1, minWidth: 180 },
    { field: 'pickupDate', headerName: 'Pickup Date', flex: 1, minWidth: 140, renderCell: (params) => params.row.pickupDate ? new Date(params.row.pickupDate).toLocaleDateString() : '' },
    { field: 'dropOffDate', headerName: 'DropOff Date', flex: 1, minWidth: 140, renderCell: (params) => params.row.dropOffDate ? new Date(params.row.dropOffDate).toLocaleDateString() : '' },
    { field: 'payment', headerName: 'Payment', flex: 1, minWidth: 100, renderCell: (params) => params.row.payment ? `$${Number(params.row.payment.amount).toFixed(2)}` : '' },
    {
      field: 'statusAction',
      headerName: 'Change Status',
      width: 160,
      sortable: false,
      renderCell: (params) => (
        <Select
          value={params.row.status}
          size="small"
          onChange={async (e) => {
            try {
              await axios.patch(`/api/v1/bookings/${params.row.id}/status`, { status: e.target.value });
              setSnackbar({ open: true, message: 'Status updated', severity: 'success' });
              fetchAllData();
            } catch {
              setSnackbar({ open: true, message: 'Failed to update status', severity: 'error' });
            }
          }}
        >
          {statusOptions.map((s) => (
            <MenuItem key={s} value={s}>{s.charAt(0).toUpperCase() + s.slice(1)}</MenuItem>
          ))}
        </Select>
      ),
    },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 120,
      sortable: false,
      renderCell: (params) => (
        <>
          <IconButton color="primary" onClick={() => handleEdit(params.row)}>
            <EditIcon />
          </IconButton>
          <IconButton color="error" onClick={() => handleDelete(params.row)}>
            <DeleteIcon />
          </IconButton>
        </>
      ),
    },
  ];

  return (
    <Box>
      <Box display="flex" alignItems="center" justifyContent="space-between" mb={3}>
        <Typography variant="h4" fontWeight={700}>
          Bookings
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
      {/* Edit Booking Modal */}
      <Dialog open={editOpen} onClose={() => setEditOpen(false)} maxWidth="xs" fullWidth>
        <DialogTitle>Edit Booking Status</DialogTitle>
        <DialogContent dividers>
          <Select
            value={status}
            onChange={e => setStatus(e.target.value)}
            fullWidth
          >
            {statusOptions.map((s) => (
              <MenuItem key={s} value={s}>{s.charAt(0).toUpperCase() + s.slice(1)}</MenuItem>
            ))}
          </Select>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setEditOpen(false)} color="secondary">
            Cancel
          </Button>
          <Button onClick={handleEditSave} variant="contained" color="primary">
            Save
          </Button>
        </DialogActions>
      </Dialog>
      {/* Delete Booking Modal */}
      <Dialog open={deleteOpen} onClose={() => setDeleteOpen(false)} maxWidth="xs" fullWidth>
        <DialogTitle>Delete Booking</DialogTitle>
        <DialogContent dividers>
          Are you sure you want to delete this booking?
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setDeleteOpen(false)} color="secondary">
            Cancel
          </Button>
          <Button onClick={handleDeleteConfirm} variant="contained" color="error">
            Delete
          </Button>
        </DialogActions>
      </Dialog>
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