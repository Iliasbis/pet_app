# Palm Kissed Paws Transport - Complete System

A comprehensive pet transportation service platform with Flutter mobile app, NestJS backend, React admin dashboard, and MySQL database.

## 🌴 Project Overview

Palm Kissed Paws Transport is an "Uber for pets" service featuring:
- **Flutter Mobile App** with MVVM architecture and GetX state management
- **NestJS Backend API** with TypeORM and MySQL
- **React Admin Dashboard** for managing bookings, users, and services
- **Tropical-themed UI** with turquoise, pink, and purple colors

## 🚀 Phase 1 MVP Features

### Mobile App Features
- ✅ User authentication (register/login)
- ✅ Pet profile management
- ✅ Service booking with pricing calculator
- ✅ Booking history and status tracking
- ✅ User profile management
- ✅ Clean MVVM architecture with GetX

### Backend Features
- ✅ RESTful API with NestJS
- ✅ JWT authentication
- ✅ User, Pet, Booking, Service, Payment management
- ✅ Dynamic pricing calculation
- ✅ Stripe payment integration ready
- ✅ Admin endpoints for dashboard

### Admin Dashboard Features
- ✅ User management
- ✅ Booking management
- ✅ Service management
- ✅ Payment tracking
- ✅ Dashboard analytics
- ✅ Responsive design

## 🛠️ Technology Stack

### Backend
- **Framework**: NestJS with TypeScript
- **Database**: MySQL with TypeORM
- **Authentication**: JWT with Passport
- **Payments**: Stripe integration
- **API Documentation**: Swagger/OpenAPI

### Mobile App
- **Framework**: Flutter
- **State Management**: GetX
- **Architecture**: MVVM (Model-View-ViewModel)
- **HTTP Client**: Dio
- **Local Storage**: SharedPreferences

### Admin Dashboard
- **Framework**: React 18
- **Styling**: Custom CSS with design system
- **Charts**: Chart.js with react-chartjs-2
- **HTTP Client**: Axios
- **Routing**: React Router DOM

### Database
- **Primary**: MySQL 8.0+
- **ORM**: TypeORM with automatic migrations
- **Features**: Relations, indexes, constraints

## 📦 Installation & Setup

### Prerequisites
- Node.js 18+ and npm
- MySQL 8.0+
- Flutter 3.10+
- Git

### 1. Database Setup
```bash
# Run the database setup script
mysql -u root -p < database_setup.sql

# Or manually create database
mysql -u root -p
CREATE DATABASE palm_kissed_paws;
CREATE USER 'palm_kissed_user'@'localhost' IDENTIFIED BY 'secure_password_2024';
GRANT ALL PRIVILEGES ON palm_kissed_paws.* TO 'palm_kissed_user'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Backend Setup
```bash
# Install dependencies
npm install

# Configure environment variables
cp .env.example .env
# Edit .env with your database credentials and JWT secret

# Start the development server
npm run start:dev

# The API will be available at http://localhost:3000
# API Documentation at http://localhost:3000/api/docs
```

### 3. Admin Dashboard Setup
```bash
# Navigate to admin dashboard
cd admin-dashboard

# Install dependencies
npm install

# Start the development server
npm start

# Dashboard will be available at http://localhost:3001
```

### 4. Flutter App Setup
```bash
# Navigate to Flutter app
cd flutter_app

# Get dependencies
flutter pub get

# Run on iOS simulator/Android emulator
flutter run

# Or build for specific platform
flutter build apk  # Android
flutter build ios  # iOS
```

## 🔧 Configuration

### Environment Variables (.env)
```env
# Database Configuration
DATABASE_HOST=localhost
DATABASE_PORT=3306
DATABASE_NAME=palm_kissed_paws
DATABASE_USER=palm_kissed_user
DATABASE_PASSWORD=secure_password_2024

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRES_IN=24h

# App Configuration
PORT=3000
NODE_ENV=development

# Stripe Configuration (for payments)
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key
STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret
```

### Flutter App Configuration
Update `flutter_app/lib/app/core/utils/app_constants.dart`:
```dart
static const String baseUrl = 'http://localhost:3000/api/v1'; // Your API URL
```

## 📱 Mobile App Architecture

### MVVM with GetX
```
lib/
├── app/
│   ├── core/
│   │   ├── theme/          # App colors and theme
│   │   └── utils/          # Constants and utilities
│   ├── data/
│   │   ├── models/         # Data models
│   │   └── providers/      # API providers
│   ├── modules/
│   │   ├── auth/           # Authentication screens
│   │   ├── home/           # Home dashboard
│   │   ├── pets/           # Pet management
│   │   ├── booking/        # Booking creation
│   │   ├── bookings/       # Booking history
│   │   └── profile/        # User profile
│   ├── routes/             # App routing
│   └── widgets/            # Reusable widgets
└── main.dart
```

## 🎨 Design System

### Colors
- **Primary**: Turquoise (#40E0D0), Pink (#FF69B4), Purple (#9370DB)
- **Secondary**: Teal (#20B2AA), Coral (#FF7F7F), Lavender (#B19CD9)
- **Status**: Success (#4CAF50), Warning (#FF9800), Error (#F44336)

### Typography
- **Font Family**: Poppins
- **Weights**: Regular (400), Medium (500), SemiBold (600), Bold (700)
- **Scale**: 12px to 32px with 1.2-1.5 line height

## 🔐 API Endpoints

### Authentication
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - User login
- `GET /api/v1/auth/profile` - Get current user

### Pets
- `GET /api/v1/pets` - Get user's pets
- `POST /api/v1/pets` - Create new pet
- `PATCH /api/v1/pets/:id` - Update pet
- `DELETE /api/v1/pets/:id` - Delete pet

### Services
- `GET /api/v1/services` - Get available services
- `GET /api/v1/services/calculate-price/:id` - Calculate booking price

### Bookings
- `GET /api/v1/bookings` - Get user's bookings
- `POST /api/v1/bookings` - Create new booking
- `PATCH /api/v1/bookings/:id` - Update booking
- `DELETE /api/v1/bookings/:id` - Cancel booking

### Admin
- `GET /api/v1/admin/dashboard` - Dashboard statistics
- `GET /api/v1/admin/users` - All users
- `GET /api/v1/admin/bookings` - All bookings

## 🧪 Testing

### Backend Testing
```bash
# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Test coverage
npm run test:cov
```

### Flutter Testing
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/
```

## 🚀 Deployment

### Backend Deployment
1. Set `NODE_ENV=production` in environment
2. Update database credentials for production
3. Set secure JWT secret
4. Configure Stripe production keys
5. Deploy to your preferred platform (AWS, Heroku, DigitalOcean)

### Flutter App Deployment
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

### Admin Dashboard Deployment
```bash
# Build for production
npm run build

# Deploy build folder to your web server
```

## 📊 Database Schema

### Key Tables
- **users**: User accounts and profiles
- **pets**: Pet information and medical details
- **services**: Transportation service types and pricing
- **bookings**: Ride bookings with status tracking
- **payments**: Payment records and Stripe integration

## 🔮 Phase 2 Features (Future)

- 📱 Driver mobile app
- 💬 In-app messaging system
- 📍 Real-time GPS tracking
- 🔔 Push notifications
- ⭐ Rating and review system
- 🎁 Loyalty program
- 📧 Email notifications
- 📱 SMS reminders

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- 📧 Email: support@palmkissedpaws.com
- 📱 Phone: +1 (555) 123-PAWS
- 🌐 Website: https://palmkissedpaws.com

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- NestJS team for the robust backend framework
- React team for the powerful frontend library
- All the open-source contributors who made this possible

---

Made with 🌴 and 🐾 by the Palm Kissed Paws team