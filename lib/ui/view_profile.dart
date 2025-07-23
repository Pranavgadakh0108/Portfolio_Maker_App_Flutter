import 'package:flutter/material.dart';
import 'package:portfolio_creator/provider/profile_data_provider.dart';
import 'package:portfolio_creator/ui/update_data.dart';
import 'package:provider/provider.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getProfiles(context);
  }

  Future<void> getProfiles(BuildContext context) async {
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    await provider.getAllPortfolioProfiles(context);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _deleteProfile(BuildContext context, int id) async {
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    await provider.deletePortfolioProfile(id, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Portfolio Maker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ), // Custom back icon
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.purple,
        elevation: 5,
        centerTitle: true,
      ),
      body: Consumer<ProfileDataProvider>(
        builder: (context, provider, _) {
          return _isLoading
              ? Center(child: CircularProgressIndicator())
              : provider.profiles.isEmpty
              ? Center(child: Text('No Profiles Available'))
              : SafeArea(
                  child: ListView.builder(
                    itemCount: provider.profiles.length,
                    itemBuilder: (context, index) {
                      final profile = provider.profiles[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              profile?.fullName ?? "Null values found",
                            ),
                            subtitle: Text(
                              profile?.address ?? "Null values found",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateData(id: profile?.id ?? 0),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _deleteProfile(context, profile?.id ?? 0);
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
