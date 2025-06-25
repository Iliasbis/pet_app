import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useAuth } from '../contexts/AuthContext';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
} from 'chart.js';
import { Bar, Doughnut } from 'react-chartjs-2';
import { format } from 'date-fns';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement
);

const Dashboard = () => {
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const { user, loading: authLoading } = useAuth();

  const fetchDashboardData = async () => {
    try {
      setLoading(true);
      setError('');
      const response = await axios.get('/api/v1/admin/dashboard');
      setStats(response.data);
    } catch (err) {
      setError('Failed to load dashboard data');
      setStats(null);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!authLoading && user) {
      fetchDashboardData();
    }
  }, [user, authLoading]);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="loading w-8 h-8"></div>
        <span className="ml-2">Loading dashboard...</span>
      </div>
    );
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-lg p-4">
        <p className="text-red-800">{error}</p>
        <button onClick={fetchDashboardData} className="btn btn-primary mt-2">
          Retry
        </button>
      </div>
    );
  }

  const statCards = [
    {
      title: 'Total Users',
      value: stats?.totalUsers || 0,
      icon: '👥',
      color: 'var(--primary-turquoise)',
    },
    {
      title: 'Total Bookings',
      value: stats?.totalBookings || 0,
      icon: '📅',
      color: 'var(--primary-pink)',
    },
    {
      title: 'Pending Bookings',
      value: stats?.pendingBookings || 0,
      icon: '⏳',
      color: 'var(--warning)',
    },
    {
      title: 'Total Revenue',
      value: `$${stats?.totalRevenue?.toFixed(2) || '0.00'}`,
      icon: '💰',
      color: 'var(--success)',
    },
  ];

  const bookingStatusData = {
    labels: ['Pending', 'Confirmed', 'Completed'],
    datasets: [
      {
        data: [
          stats?.pendingBookings || 0,
          stats?.confirmedBookings || 0,
          stats?.completedBookings || 0,
        ],
        backgroundColor: [
          'var(--warning)',
          'var(--primary-turquoise)',
          'var(--success)',
        ],
        borderWidth: 0,
      },
    ],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'bottom',
      },
    },
  };

  return (
    <div className="space-y-6 fade-in">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Dashboard</h1>
          <p className="text-gray-600 mt-1">
            Welcome to Palm Kissed Paws Transport Admin Dashboard
          </p>
        </div>
        <button
          onClick={fetchDashboardData}
          className="btn btn-primary"
        >
          <span className="mr-2">🔄</span>
          Refresh
        </button>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {statCards.map((stat, index) => (
          <div key={index} className="card hover:shadow-xl transition-all duration-300">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-gray-600 mb-1">
                  {stat.title}
                </p>
                <p className="text-2xl font-bold" style={{ color: stat.color }}>
                  {stat.value}
                </p>
              </div>
              <div
                className="text-3xl p-3 rounded-full"
                style={{ backgroundColor: `${stat.color}20` }}
              >
                {stat.icon}
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Booking Status Chart */}
        <div className="card">
          <h3 className="text-lg font-semibold mb-4">Booking Status Distribution</h3>
          <div className="h-64">
            <Doughnut data={bookingStatusData} options={chartOptions} />
          </div>
        </div>

        {/* Recent Activity */}
        <div className="card">
          <h3 className="text-lg font-semibold mb-4">Recent Bookings</h3>
          <div className="space-y-3">
            {stats?.recentBookings?.slice(0, 5).map((booking) => (
              <div key={booking.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                <div className="flex-1">
                  <p className="font-medium text-sm">
                    {booking.user?.firstName} {booking.user?.lastName}
                  </p>
                  <p className="text-xs text-gray-500">
                    {booking.pet?.name} • {format(new Date(booking.pickupDate), 'MMM dd, yyyy')}
                  </p>
                </div>
                <div className="text-right">
                  <p className="font-semibold text-sm">${booking.totalPrice}</p>
                  <span className={`badge ${
                    booking.status === 'completed' ? 'badge-success' :
                    booking.status === 'confirmed' ? 'badge-info' :
                    booking.status === 'pending' ? 'badge-warning' :
                    'badge-secondary'
                  }`}>
                    {booking.status}
                  </span>
                </div>
              </div>
            )) || (
              <p className="text-gray-500 text-center py-4">No recent bookings</p>
            )}
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="card">
        <h3 className="text-lg font-semibold mb-4">Quick Actions</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <button className="btn btn-primary flex items-center justify-center p-4">
            <span className="text-xl mr-2">📅</span>
            <div className="text-left">
              <div className="font-semibold">View All Bookings</div>
              <div className="text-xs opacity-80">Manage customer bookings</div>
            </div>
          </button>
          <button className="btn btn-secondary flex items-center justify-center p-4">
            <span className="text-xl mr-2">👥</span>
            <div className="text-left">
              <div className="font-semibold">Manage Users</div>
              <div className="text-xs opacity-80">View customer accounts</div>
            </div>
          </button>
          <button className="btn btn-success flex items-center justify-center p-4">
            <span className="text-xl mr-2">💳</span>
            <div className="text-left">
              <div className="font-semibold">Payment Reports</div>
              <div className="text-xs opacity-80">Track revenue & payments</div>
            </div>
          </button>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;