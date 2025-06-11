import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:file_selector/file_selector.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/animated_button.dart';
import '../providers/file_provider.dart';

class FileUploadScreen extends ConsumerStatefulWidget {
  const FileUploadScreen({super.key});

  @override
  ConsumerState<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends ConsumerState<FileUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _accountTypeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _odLimitController = TextEditingController();
  final _namesController = TextEditingController();

  List<String> bankNames = [
    'APMAHESH',
    'Arab National Bank',
    'Axis Bank',
    'Bank of Baroda',
    'Bank of India',
    'Bank of Maharashtra',
    'Canara Bank',
    'Citi Bank',
    'City Union Bank',
    'DBS Bank',
    'Dhanlaxmi Bank',
    'Federal Bank',
    'HDFC Bank',
    'ICICI Bank',
    'IDBI',
    'IDFC Bank',
    'Indian Bank',
  ];

  List<String> _accountType = ['Savings', 'Current'];

  String? _selectedBankName;
  String? _actualBankName;
  String? _selectedAccountType;
  String? _selectedFilePath;
  String? _selectedFileName;
  bool isHelp=false; 

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountTypeController.dispose();
    _passwordController.dispose();
    _odLimitController.dispose();
    _namesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileState = ref.watch(fileNotifierProvider);

    ref.listen(fileNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (result) {
          if (result != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('File uploaded successfully!'),
                backgroundColor: AppTheme.accentGreen,
              ),
            );
            context.pop();
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload File'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFileUploadArea(),
              const SizedBox(height: 24),
              _buildFormFields(),
              const SizedBox(height: 32),
              _buildUploadButton(fileState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadArea() {
    return GlassCard(
      child: InkWell(
        onTap: () async {
          const typeGroup = XTypeGroup(
              label: 'documents', extensions: ['pdf', 'docx', 'xlsx']);
          final file = await openFile(acceptedTypeGroups: [typeGroup]);
          if (file != null) {
            setState(() {
              _selectedFilePath = file.path;
              _selectedFileName = file.name;
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.primaryTeal.withOpacity(0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud_upload_outlined,
                size: 64,
                color: AppTheme.primaryTeal,
              ).animate().scale(duration: 300.ms),
              const SizedBox(height: 16),
              Text(
                _selectedFileName ?? 'Tap to select a file',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryTeal,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                _selectedFilePath ?? 'Only PDF, DOCX, XLSX supported',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        DropdownButtonFormField2(
          value: _selectedBankName,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Bank Name',
            prefixIcon: Icon(Icons.account_balance),
          ),

          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter bank name';
            }
            return null;
          },

          items: bankNames.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedBankName = value.toString();
              _actualBankName = _selectedBankName!.replaceAll(" ", "_");
              log("$_actualBankName");
            });
          },
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 300, // LIMITS THE HEIGHT OF DROPDOWN
          ), // << LIMITS the dropdown height here
        ).animate().slideX(delay: 400.ms, duration: 400.ms),

        const SizedBox(height: 16),
        // DropdownButtonFormField(
        //   value: _selectedBankName,
        //   decoration: const InputDecoration(
        //     labelText: 'Bank Name',
        //     prefixIcon: Icon(Icons.account_balance),
        //   ),
        //   items: bankNames.map(
        //     (String item) {
        //       return DropdownMenuItem(
        //         value: item,
        //         child: Text(item),
        //       );
        //     },
        //   ).toList(),
        //   onChanged: (value) {
        //     setState(() {
        //       _selectedBankName = value.toString();
        //       _actualBankName = _selectedBankName!.replaceAll(" ", "_");
        //       log("$_actualBankName");
        //     });
        //   },
        // ).animate().slideX(delay: 400.ms, duration: 400.ms),
        // const SizedBox(height: 16),
        // TextFormField(
        //   controller: _bankNameController,
        //   decoration: const InputDecoration(
        //     labelText: 'Bank Name',
        //     prefixIcon: Icon(Icons.account_balance),
        //   ),
        //   validator: (value) {
        //     if (value?.isEmpty ?? true) {
        //       return 'Please enter bank name';
        //     }
        //     return null;
        //   },
        // ).animate().slideX(delay: 200.ms, duration: 400.ms),

        DropdownButtonFormField2(
          value: _selectedAccountType,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Account Type',
            prefixIcon: Icon(Icons.account_balance),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter account type';
            }
            return null;
          },

          items: _accountType.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedAccountType = value.toString();
            });
          },
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 300, // LIMITS THE HEIGHT OF DROPDOWN
          ), // << LIMITS the dropdown height here
        ).animate().slideX(delay: 400.ms, duration: 400.ms),
        const SizedBox(height: 16),
        // TextFormField(
        //   controller: _accountTypeController,
        //   decoration: const InputDecoration(
        //     labelText: 'Account Type',
        //     prefixIcon: Icon(Icons.account_box),
        //   ),
        //   validator: (value) {
        //     if (value?.isEmpty ?? true) {
        //       return 'Please enter account type';
        //     }
        //     return null;
        //   },
        // ).animate().slideX(delay: 300.ms, duration: 400.ms),
        // const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Document Password (if any)',
            prefixIcon: Icon(Icons.lock),
          ),
        ).animate().slideX(delay: 400.ms, duration: 400.ms),
        const SizedBox(height: 16),
        (_selectedAccountType == "Current")
            ? TextFormField(
                controller: _odLimitController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Company Names (In-house Transactions)',
                  prefixIcon: Icon(Icons.money),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter Company Names (In-house Transactions)';
                  }
                  return null;
                },
              ).animate().slideX(delay: 50.ms, duration: 400.ms)
            : const SizedBox(),
              (_selectedAccountType == "Current")
            ? const SizedBox(height:5)
            : const SizedBox(),

        (_selectedAccountType == "Current")
            ? GestureDetector(
              onTap: () {
                if(isHelp){
                  isHelp=false;
                }else{
                  isHelp=true;
                }
                setState(() {
                  
                });
              },
              child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Icon(Icons.info_outline,size: 14,), Text("Help")],
                ),
            )
            : SizedBox(),

     

            (isHelp)?Text("Company Names (In-house Transactions): Please enter the names of the companies associated with this account for in-house transactions.\n\nSeparate the company names using commas (e.g., Company A, Company B, Company C).\n\nThis will help link the account to the appropriate internal companies for identification and proper transaction processing."):SizedBox(),
       
          (_selectedAccountType == "Current")
            ? const SizedBox(height: 16)
            : const SizedBox(),

        TextFormField(
          controller: _namesController,
          decoration: const InputDecoration(
            labelText: 'Account Holder Names',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter account holder names';
            }
            return null;
          },
        ).animate().slideX(delay: 600.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildUploadButton(AsyncValue fileState) {
    final isDisabled = _selectedFilePath == null || fileState.isLoading;

    return SizedBox(
      width: double.infinity,
      child: AnimatedButton(
        onPressed: isDisabled
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  ref.read(fileNotifierProvider.notifier).uploadFile(
                        filePath: _selectedFilePath!,
                        bankName: _actualBankName!,
                        accountType: _selectedAccountType!,
                        password: _passwordController.text,
                        odLimit: _odLimitController.text,
                        names: _namesController.text,
                      );
                }
              },
        gradient: AppTheme.primaryGradient,
        child: Text(
          fileState.isLoading ? 'Uploading...' : 'Upload File',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ).animate().slideY(delay: 700.ms, duration: 400.ms);
  }
}
