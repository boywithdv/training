import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final heightProvider = StateProvider<double>((ref) => 100.0);
final weightProvider = StateProvider<double>((ref) => 50.0);
