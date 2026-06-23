import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_safearea/models/report_model.dart';
import 'package:proyecto_safearea/models/user_model.dart';

void main() {
  // ============================================================
  // PRUEBAS PARA REPORT MODEL
  // ============================================================
  group('Report Model Tests', () {
    test('fromMap should create Report from map', () {
      final map = {
        'id': 'test-id',
        'userId': 'user-id',
        'type': 'robo',
        'title': 'Test Report',
        'description': 'Test Description',
        'location': 'Test Location',
        'status': 'activo',
        'images': ['image1.jpg', 'image2.jpg'],
        'createdAt': '2024-01-01T00:00:00.000Z',
        'updatedAt': '2024-01-01T00:00:00.000Z',
        'verifiedBy': [],
        'isActive': true,
        'latitude': -18.0056,
        'longitude': -70.2483,
      };

      final report = Report.fromMap(map);

      expect(report.id, 'test-id');
      expect(report.userId, 'user-id');
      expect(report.type, 'robo');
      expect(report.title, 'Test Report');
      expect(report.description, 'Test Description');
      expect(report.location, 'Test Location');
      expect(report.status, 'activo');
      expect(report.images, hasLength(2));
      expect(report.images.first, 'image1.jpg');
      expect(report.isActive, true);
      expect(report.latitude, -18.0056);
      expect(report.longitude, -70.2483);
    });

    test('toMap should create map from Report', () {
      final report = Report(
        id: 'test-id',
        userId: 'user-id',
        type: 'incendio',
        title: 'Fire Report',
        description: 'Fire Description',
        location: 'Fire Location',
        status: 'en_proceso',
        images: ['fire1.jpg'],
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        verifiedBy: [],
        isActive: true,
      );

      final map = report.toMap();

      expect(map['id'], 'test-id');
      expect(map['userId'], 'user-id');
      expect(map['type'], 'incendio');
      expect(map['title'], 'Fire Report');
      expect(map['status'], 'en_proceso');
      expect(map['images'], hasLength(1));
      expect(map['isActive'], true);
    });

    test('copyWith should create copy with updated fields', () {
      final original = Report(
        id: 'test-id',
        userId: 'user-id',
        type: 'robo',
        title: 'Original Title',
        description: 'Original Description',
        location: 'Original Location',
        status: 'activo',
        images: [],
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        verifiedBy: [],
        isActive: true,
      );

      final updated = original.copyWith(
        title: 'Updated Title',
        status: 'resuelto',
        images: ['new-image.jpg'],
      );

      expect(updated.id, original.id);
      expect(updated.title, 'Updated Title');
      expect(updated.status, 'resuelto');
      expect(updated.images, hasLength(1));
      expect(updated.description, original.description);
    });
  });

  // ============================================================
  // PRUEBAS PARA USER MODEL
  // ============================================================
  group('UserModel Tests', () {
    test('fromMap should create UserModel from map', () {
      final map = {
        'id': 'user-id',
        'email': 'test@example.com',
        'name': 'Test User',
        'phone': '+51987654321',
        'profileImage': 'https://example.com/image.jpg',
        'createdAt': '2024-01-01T00:00:00.000Z',
        'role': 'user',
      };

      final user = UserModel.fromMap(map);

      expect(user.id, 'user-id');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.phone, '+51987654321');
      expect(user.profileImage, 'https://example.com/image.jpg');
      expect(user.role, 'user');
      expect(user.isAdmin, false);
    });

    test('fromMap should default role to user if not provided', () {
      final map = {
        'id': 'user-id',
        'email': 'test@example.com',
        'name': 'Test User',
        'createdAt': '2024-01-01T00:00:00.000Z',
      };

      final user = UserModel.fromMap(map);

      expect(user.role, 'user');
      expect(user.isAdmin, false);
    });

    test('toMap should create map from UserModel', () {
      final user = UserModel(
        id: 'user-id',
        email: 'test@example.com',
        name: 'Test User',
        phone: '+51987654321',
        profileImage: 'https://example.com/image.jpg',
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        role: 'admin',
      );

      final map = user.toMap();

      expect(map['id'], 'user-id');
      expect(map['email'], 'test@example.com');
      expect(map['name'], 'Test User');
      expect(map['phone'], '+51987654321');
      expect(map['role'], 'admin');
    });

    test('isAdmin should return true for admin role', () {
      final admin = UserModel(
        id: 'admin-id',
        email: 'admin@example.com',
        name: 'Admin User',
        createdAt: DateTime.now(),
        role: 'admin',
      );

      expect(admin.isAdmin, true);
      expect(admin.canModerate(), true);
    });

    test('isAdmin should return false for user role', () {
      final user = UserModel(
        id: 'user-id',
        email: 'user@example.com',
        name: 'Regular User',
        createdAt: DateTime.now(),
        role: 'user',
      );

      expect(user.isAdmin, false);
      expect(user.canModerate(), false);
    });
  });
}