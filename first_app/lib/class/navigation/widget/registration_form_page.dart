// TODO Implement this library.
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      theme: ThemeData(
        primarySwatch: Colors.purple, // สีหลักตามตัวอย่าง
      ),
      home: const RegistrationFormPage(),
      debugShowCheckedModeBanner: false, // ปิด banner debug
    );
  }
}

class RegistrationFormPage extends StatefulWidget {
  const RegistrationFormPage({super.key});

  @override
  State<RegistrationFormPage> createState() => _RegistrationFormPageState();
}

class _RegistrationFormPageState extends State<RegistrationFormPage> {
  // ตัวแปรสำหรับเก็บค่าจาก Input fields
  final _formKey = GlobalKey<FormState>(); // ใช้สำหรับจัดการ Form และ Validation
  String? _fullName;
  String? _email;
  String? _gender; // 'Male' or 'Female'
  String? _province;
  bool _acceptTerms = false;

  // รายการจังหวัดสำหรับ Dropdown
  final List<String> _provinces = ['Bangkok', 'Chiang Mai', 'Phuket', 'Khon Kaen'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
        backgroundColor: Colors.purple, // ตั้งสี AppBar ให้ตรง
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // ผูก GlobalKey เข้ากับ Form
          child: ListView( // ใช้ ListView เพื่อให้ scroll ได้ถ้า content เยอะ
            children: <Widget>[
              // --- 1. ชื่อ-นามสกุล (TextFormField) ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(), // เพิ่มขอบให้เหมือนตัวอย่าง
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fullName = value;
                },
              ),
              const SizedBox(height: 16.0), // ระยะห่าง

              // --- 2. อีเมล (TextFormField) ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress, // ตั้ง Keyboard Type เป็น email
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // เพิ่มการ validate รูปแบบอีเมลเบื้องต้น
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              const SizedBox(height: 16.0),

              // --- 3. เพศ (Radio Button) ---
              const Text('Gender', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'Male',
                    groupValue: _gender,
                    onChanged: (String? newValue) {
                      setState(() {
                        _gender = newValue;
                      });
                    },
                  ),
                  const Text('Male'),
                  const SizedBox(width: 16.0),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _gender,
                    onChanged: (String? newValue) {
                      setState(() {
                        _gender = newValue;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              // อาจจะมีการ validate เพศว่าต้องเลือก
              // if (_gender == null) Text('Please select your gender', style: TextStyle(color: Colors.red)),
              const SizedBox(height: 16.0),

              // --- 4. จังหวัด (Dropdown) ---
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Province',
                  border: OutlineInputBorder(),
                ),
                items: _provinces.map((String province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _province = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your province';
                  }
                  return null;
                },
                value: _province, // กำหนดค่าเริ่มต้น (ถ้ามี)
              ),
              const SizedBox(height: 16.0),

              // --- 5. ยอมรับเงื่อนไข (Checkbox) ---
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _acceptTerms = newValue ?? false;
                      });
                    },
                  ),
                  const Text('Accept Terms & Conditions'),
                ],
              ),
              // อาจจะมีการ validate เช็คบ็อกซ์
              // if (!_acceptTerms) Text('You must accept the terms and conditions', style: TextStyle(color: Colors.red)),
              const SizedBox(height: 24.0),

              // --- 6. ปุ่ม Submit ---
              ElevatedButton(
                onPressed: () {
                  // ตรวจสอบ validation ก่อน
                  if (_formKey.currentState!.validate()) {
                    // ถ้า validation ผ่าน
                    _formKey.currentState!.save(); // เรียก onSaved ทุก field

                    // ตรวจสอบเงื่อนไขเพิ่มเติม (เช่น ต้องเลือกเพศ และยอมรับเงื่อนไข)
                    if (_gender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select your gender')),
                      );
                      return; // หยุดการทำงาน
                    }
                    if (!_acceptTerms) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('You must accept the terms and conditions')),
                      );
                      return; // หยุดการทำงาน
                    }

                    // ถ้าทุกอย่างพร้อม ค่อยแสดงข้อมูล (ในแอปจริงอาจจะส่งข้อมูลไป server)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Form Submitted!\n'
                            'Full Name: $_fullName\n'
                            'Email: $_email\n'
                            'Gender: $_gender\n'
                            'Province: $_province\n'
                            'Accepted Terms: $_acceptTerms'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // สามารถ reset form ได้ถ้าต้องการ
                    // _formKey.currentState!.reset();
                    // setState(() {
                    //   _gender = null;
                    //   _province = null;
                    //   _acceptTerms = false;
                    // });
                  } else {
                    // ถ้า validation ไม่ผ่าน
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fix the errors in the form')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // ตั้งค่าสีปุ่มให้คล้ายตัวอย่าง (อาจจะต้องปรับแต่งเพิ่มเติม)
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}