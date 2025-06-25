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
  CircularProgress,
  Snackbar,
  Alert,
  MenuItem,
} from '@mui/material';
import { DataGrid } from '@mui/x-data-grid';
import EditIcon from '@mui/icons-material/Edit';
import AddIcon from '@mui/icons-material/Add';
import DeleteIcon from '@mui/icons-material/Delete';

export default function Services() {
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [editOpen, setEditOpen] = useState(false);
  const [addOpen, setAddOpen] = useState(false);
  const [deleteOpen, setDeleteOpen] = useState(false);
  const [selected, setSelected] = useState(null);
  const [form, setForm] = useState({
    name: '',
    description: '',
    type: '',
    smallPetPrice: '',
    mediumPetPrice: '',
    largePetPrice: '',
    cratePrice: '',
    medicationPrice: '',
    waitReturnHourlyPrice: '',
    specialTimePrice: '',
    roundTripMultiplier: '',
    isActive: true,
  });
  const [snackbar, setSnackbar] = useState({ open: false, message: '', severity: 'success' });
  const { user, loading: authLoading } = useAuth();

  const fetchServices = async () => {
    setLoading(true);
    setError('');
    try {
      const res = await axios.get('/api/v1/admin/services');
      console.log('Services API:', res.data);
      setRows(res.data || []);
    } catch (err) {
      setError('Failed to load services');
      setRows([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!authLoading && user) {
      fetchServices();
    }
  }, [user, authLoading]);

  const handleEdit = (row) => {
    setSelected(row);
    setForm({
      name: row.name || '',
      description: row.description || '',
      type: row.type || '',
      smallPetPrice: row.smallPetPrice || '',
      mediumPetPrice: row.mediumPetPrice || '',
      largePetPrice: row.largePetPrice || '',
      cratePrice: row.cratePrice || '',
      medicationPrice: row.medicationPrice || '',
      waitReturnHourlyPrice: row.waitReturnHourlyPrice || '',
      specialTimePrice: row.specialTimePrice || '',
      roundTripMultiplier: row.roundTripMultiplier || '',
      isActive: row.isActive !== undefined ? row.isActive : true,
    });
    setEditOpen(true);
  };

  const handleEditSave = async () => {
    try {
      await axios.patch(`/api/v1/services/${selected.id}`, {
        ...form,
        smallPetPrice: Number(form.smallPetPrice),
        mediumPetPrice: Number(form.mediumPetPrice),
        largePetPrice: Number(form.largePetPrice),
        cratePrice: Number(form.cratePrice),
        medicationPrice: Number(form.medicationPrice),
        waitReturnHourlyPrice: Number(form.waitReturnHourlyPrice),
        specialTimePrice: Number(form.specialTimePrice),
        roundTripMultiplier: Number(form.roundTripMultiplier),
        isActive: Boolean(form.isActive),
      });
      setSnackbar({ open: true, message: 'Service updated', severity: 'success' });
      fetchServices();
    } catch (err) {
      setSnackbar({ open: true, message: 'Failed to update service', severity: 'error' });
    }
    setEditOpen(false);
    setSelected(null);
  };

  const handleAdd = () => {
    setForm({
      name: '',
      description: '',
      type: '',
      smallPetPrice: '',
      mediumPetPrice: '',
      largePetPrice: '',
      cratePrice: '',
      medicationPrice: '',
      waitReturnHourlyPrice: '',
      specialTimePrice: '',
      roundTripMultiplier: '',
      isActive: true,
    });
    setAddOpen(true);
  };

  const handleAddSave = async () => {
    try {
      await axios.post('/api/v1/services', {
        ...form,
        smallPetPrice: Number(form.smallPetPrice),
        mediumPetPrice: Number(form.mediumPetPrice),
        largePetPrice: Number(form.largePetPrice),
        cratePrice: Number(form.cratePrice),
        medicationPrice: Number(form.medicationPrice),
        waitReturnHourlyPrice: Number(form.waitReturnHourlyPrice),
        specialTimePrice: Number(form.specialTimePrice),
        roundTripMultiplier: Number(form.roundTripMultiplier),
        isActive: Boolean(form.isActive),
      });
      setSnackbar({ open: true, message: 'Service added', severity: 'success' });
      fetchServices();
    } catch (err) {
      setSnackbar({ open: true, message: 'Failed to add service', severity: 'error' });
    }
    setAddOpen(false);
  };

  const handleDelete = (row) => {
    setSelected(row);
    setDeleteOpen(true);
  };

  const handleDeleteConfirm = async () => {
    try {
      await axios.delete(`/api/v1/services/${selected.id}`);
      setSnackbar({ open: true, message: 'Service deleted', severity: 'success' });
      fetchServices();
    } catch (err) {
      setSnackbar({ open: true, message: 'Failed to delete service', severity: 'error' });
    }
    setDeleteOpen(false);
    setSelected(null);
  };

  const columns = [
    { field: 'id', headerName: 'ID', width: 90, renderCell: (params) => params.row.id || '' },
    { field: 'name', headerName: 'Name', flex: 1, minWidth: 120, renderCell: (params) => params.row.name || '' },
    { field: 'description', headerName: 'Description', flex: 1, minWidth: 180, renderCell: (params) => params.row.description || '' },
    { field: 'type', headerName: 'Type', flex: 1, minWidth: 100, renderCell: (params) => params.row.type || '' },
    { field: 'smallPetPrice', headerName: 'Small Pet Price', flex: 1, minWidth: 120, renderCell: (params) => params.row.smallPetPrice !== undefined ? `$${Number(params.row.smallPetPrice).toFixed(2)}` : '' },
    { field: 'mediumPetPrice', headerName: 'Medium Pet Price', flex: 1, minWidth: 120, renderCell: (params) => params.row.mediumPetPrice !== undefined ? `$${Number(params.row.mediumPetPrice).toFixed(2)}` : '' },
    { field: 'largePetPrice', headerName: 'Large Pet Price', flex: 1, minWidth: 120, renderCell: (params) => params.row.largePetPrice !== undefined ? `$${Number(params.row.largePetPrice).toFixed(2)}` : '' },
    { field: 'cratePrice', headerName: 'Crate Price', flex: 1, minWidth: 100, renderCell: (params) => params.row.cratePrice !== undefined ? `$${Number(params.row.cratePrice).toFixed(2)}` : '' },
    { field: 'medicationPrice', headerName: 'Medication Price', flex: 1, minWidth: 120, renderCell: (params) => params.row.medicationPrice !== undefined ? `$${Number(params.row.medicationPrice).toFixed(2)}` : '' },
    { field: 'waitReturnHourlyPrice', headerName: 'Wait/Return Hourly Price', flex: 1, minWidth: 160, renderCell: (params) => params.row.waitReturnHourlyPrice !== undefined ? `$${Number(params.row.waitReturnHourlyPrice).toFixed(2)}` : '' },
    { field: 'specialTimePrice', headerName: 'Special Time Price', flex: 1, minWidth: 140, renderCell: (params) => params.row.specialTimePrice !== undefined ? `$${Number(params.row.specialTimePrice).toFixed(2)}` : '' },
    { field: 'roundTripMultiplier', headerName: 'Round Trip Multiplier', flex: 1, minWidth: 140, renderCell: (params) => params.row.roundTripMultiplier !== undefined ? Number(params.row.roundTripMultiplier).toFixed(2) : '' },
    { field: 'isActive', headerName: 'Active', flex: 1, minWidth: 80, renderCell: (params) => params.row.isActive ? 'Yes' : 'No' },
    { field: 'createdAt', headerName: 'Created At', flex: 1, minWidth: 140, renderCell: (params) => params.row.createdAt ? new Date(params.row.createdAt).toLocaleString() : '' },
    { field: 'updatedAt', headerName: 'Updated At', flex: 1, minWidth: 140, renderCell: (params) => params.row.updatedAt ? new Date(params.row.updatedAt).toLocaleString() : '' },
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
          Services
        </Typography>
        <Button variant="contained" startIcon={<AddIcon />} onClick={handleAdd}>
          Add Service
        </Button>
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
      {/* Edit Service Modal */}
      <Dialog open={editOpen} onClose={() => setEditOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Edit Service</DialogTitle>
        <DialogContent dividers>
          <TextField label="Name" fullWidth margin="normal" value={form.name} onChange={e => setForm(f => ({ ...f, name: e.target.value }))} />
          <TextField label="Description" fullWidth margin="normal" value={form.description} onChange={e => setForm(f => ({ ...f, description: e.target.value }))} />
          <TextField label="Type" fullWidth margin="normal" value={form.type} onChange={e => setForm(f => ({ ...f, type: e.target.value }))} />
          <TextField label="Small Pet Price" type="number" fullWidth margin="normal" value={form.smallPetPrice} onChange={e => setForm(f => ({ ...f, smallPetPrice: e.target.value }))} />
          <TextField label="Medium Pet Price" type="number" fullWidth margin="normal" value={form.mediumPetPrice} onChange={e => setForm(f => ({ ...f, mediumPetPrice: e.target.value }))} />
          <TextField label="Large Pet Price" type="number" fullWidth margin="normal" value={form.largePetPrice} onChange={e => setForm(f => ({ ...f, largePetPrice: e.target.value }))} />
          <TextField label="Crate Price" type="number" fullWidth margin="normal" value={form.cratePrice} onChange={e => setForm(f => ({ ...f, cratePrice: e.target.value }))} />
          <TextField label="Medication Price" type="number" fullWidth margin="normal" value={form.medicationPrice} onChange={e => setForm(f => ({ ...f, medicationPrice: e.target.value }))} />
          <TextField label="Wait/Return Hourly Price" type="number" fullWidth margin="normal" value={form.waitReturnHourlyPrice} onChange={e => setForm(f => ({ ...f, waitReturnHourlyPrice: e.target.value }))} />
          <TextField label="Special Time Price" type="number" fullWidth margin="normal" value={form.specialTimePrice} onChange={e => setForm(f => ({ ...f, specialTimePrice: e.target.value }))} />
          <TextField label="Round Trip Multiplier" type="number" fullWidth margin="normal" value={form.roundTripMultiplier} onChange={e => setForm(f => ({ ...f, roundTripMultiplier: e.target.value }))} />
          <TextField label="Active" select fullWidth margin="normal" value={form.isActive} onChange={e => setForm(f => ({ ...f, isActive: e.target.value === 'true' }))} >
            <MenuItem value={true}>Yes</MenuItem>
            <MenuItem value={false}>No</MenuItem>
          </TextField>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setEditOpen(false)} color="secondary">Cancel</Button>
          <Button onClick={handleEditSave} variant="contained" color="primary">Save</Button>
        </DialogActions>
      </Dialog>
      {/* Add Service Modal */}
      <Dialog open={addOpen} onClose={() => setAddOpen(false)} maxWidth="sm" fullWidth>
        <DialogTitle>Add New Service</DialogTitle>
        <DialogContent dividers>
          <TextField label="Name" fullWidth margin="normal" value={form.name} onChange={e => setForm(f => ({ ...f, name: e.target.value }))} />
          <TextField label="Description" fullWidth margin="normal" value={form.description} onChange={e => setForm(f => ({ ...f, description: e.target.value }))} />
          <TextField label="Type" fullWidth margin="normal" value={form.type} onChange={e => setForm(f => ({ ...f, type: e.target.value }))} />
          <TextField label="Small Pet Price" type="number" fullWidth margin="normal" value={form.smallPetPrice} onChange={e => setForm(f => ({ ...f, smallPetPrice: e.target.value }))} />
          <TextField label="Medium Pet Price" type="number" fullWidth margin="normal" value={form.mediumPetPrice} onChange={e => setForm(f => ({ ...f, mediumPetPrice: e.target.value }))} />
          <TextField label="Large Pet Price" type="number" fullWidth margin="normal" value={form.largePetPrice} onChange={e => setForm(f => ({ ...f, largePetPrice: e.target.value }))} />
          <TextField label="Crate Price" type="number" fullWidth margin="normal" value={form.cratePrice} onChange={e => setForm(f => ({ ...f, cratePrice: e.target.value }))} />
          <TextField label="Medication Price" type="number" fullWidth margin="normal" value={form.medicationPrice} onChange={e => setForm(f => ({ ...f, medicationPrice: e.target.value }))} />
          <TextField label="Wait/Return Hourly Price" type="number" fullWidth margin="normal" value={form.waitReturnHourlyPrice} onChange={e => setForm(f => ({ ...f, waitReturnHourlyPrice: e.target.value }))} />
          <TextField label="Special Time Price" type="number" fullWidth margin="normal" value={form.specialTimePrice} onChange={e => setForm(f => ({ ...f, specialTimePrice: e.target.value }))} />
          <TextField label="Round Trip Multiplier" type="number" fullWidth margin="normal" value={form.roundTripMultiplier} onChange={e => setForm(f => ({ ...f, roundTripMultiplier: e.target.value }))} />
          <TextField label="Active" select fullWidth margin="normal" value={form.isActive} onChange={e => setForm(f => ({ ...f, isActive: e.target.value === 'true' }))} >
            <MenuItem value={true}>Yes</MenuItem>
            <MenuItem value={false}>No</MenuItem>
          </TextField>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setAddOpen(false)} color="secondary">Cancel</Button>
          <Button onClick={handleAddSave} variant="contained" color="primary">Add</Button>
        </DialogActions>
      </Dialog>
      {/* Delete Service Modal */}
      <Dialog open={deleteOpen} onClose={() => setDeleteOpen(false)} maxWidth="xs" fullWidth>
        <DialogTitle>Delete Service</DialogTitle>
        <DialogContent dividers>
          Are you sure you want to delete this service?
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