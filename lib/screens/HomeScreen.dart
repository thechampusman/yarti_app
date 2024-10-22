import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../funcations/googlePlacesProvider.dart';
import '../funcations/imageSlider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedTripType = 0; // 0 = Outstation, 1 = Local, 2 = Airport
  int selectedOutstationType = 0; // 0 = One Way, 1 = Round Trip
  int selectedAirportType = 0; // 0 = To Airport, 1 = From Airport
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header -------------------------
                _buildHeader(),
                SizedBox(
                  height: height * 0.005,
                ),
                // heading text -------------------
                _buildHeadingText(),
                SizedBox(
                  height: height * 0.03, // Space before the Image Slider
                ),
                // Image Slider
                ImageSlider(),

                SizedBox(
                  height: height * 0.03,
                ),

                // Trip Type Tabs (Outstation, Local, Airport Transfer)
                _buildTripTypeTabs(),
                SizedBox(
                  height: height * 0.015,
                ),
                // Show corresponding content based on selected trip type
                if (selectedTripType == 0) _buildOutstationTabs(),
                SizedBox(height: height * 0.02),
                Container(child: _buildDynamicForm()),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.03),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(16), // Rounded corners
                      color: Colors.white, // Optional: Add background color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // Optional: Shadow for depth
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    clipBehavior:
                        Clip.hardEdge, // Clip the image to the border radius
                    child: Image.asset(
                      'assets/cab.png', // Replace with your image path
                      fit: BoxFit.cover, // Adjust image to cover the container
                      width: width, // Desired width of the container
                      height: height * 0.2, // Desired height of the container
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutstationSubTab(String title, int index) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOutstationType = index;
        });
      },
      child: Container(
        width: width * 0.4,
        padding: EdgeInsets.symmetric(
            vertical: height * 0.005, horizontal: width * 0.05),
        decoration: BoxDecoration(
          color: selectedOutstationType == index ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            color:
                selectedOutstationType == index ? Colors.white : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAirportSubTabs() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // "To the Airport" sub-tab
        GestureDetector(
          onTap: () {
            setState(() {
              selectedAirportType = 0; // Update selected tab index
            });
          },
          child: Container(
            width: width * 0.45,
            padding: EdgeInsets.symmetric(
                vertical: height * 0.005, horizontal: width * 0.05),
            decoration: BoxDecoration(
              color: selectedAirportType == 0
                  ? Colors.green
                  : Colors.white, // Change color
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              textAlign: TextAlign.center,
              'To The Airport',
              style: TextStyle(
                color: selectedAirportType == 0
                    ? Colors.white
                    : Colors.green, // Text color
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // "From the Airport" sub-tab
        GestureDetector(
          onTap: () {
            setState(() {
              selectedAirportType = 1; // Update selected tab index
            });
          },
          child: Container(
            width: width * 0.45,
            padding: EdgeInsets.symmetric(
                vertical: height * 0.005, horizontal: width * 0.05),
            decoration: BoxDecoration(
              color: selectedAirportType == 1
                  ? Colors.green
                  : Colors.white, // Change color
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              textAlign: TextAlign.center,
              'From The Airport',
              style: TextStyle(
                color: selectedAirportType == 1
                    ? Colors.white
                    : Colors.green, // Text color
                fontWeight: FontWeight.bold, fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField(
    String labelText,
    String prefixImage,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        setState(() {}); // Trigger rebuild to update the suffix icon
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFD5F2C8),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Type City Name",
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(prefixImage, width: 30, height: 30),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(12),
      //   borderSide: BorderSide(
      //     color: Colors.green,
      //     width: 2,
      //   ),
      // ),
    );
  }

  Widget _buildFormFieldWithAutocomplete(String labelText, String prefixImage,
      TextEditingController controller, bool isPickup) {
    final suggestions = ref.watch(isPickup
        ? pickupSuggestionsProvider
        : dropSuggestionsProvider); // Separate providers

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000), // Shadow color with 15% opacity
            offset: Offset(0, 4), // Vertical shadow offset
            blurRadius: 4, // Blur radius
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            onChanged: (input) {
              ref
                  .read(isPickup
                      ? pickupSuggestionsProvider.notifier
                      : dropSuggestionsProvider.notifier)
                  .fetchSuggestions(
                      input); // Directly call the provider's method
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Color(0xFFD5F2C8),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.green),
              hintText: "Type City Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(prefixImage, width: 30, height: 30),
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        controller.clear();
                        // Clear the text field
                        setState(
                            () {}); // Update the state to remove the cross icon
                      },
                    )
                  : Icon(Icons.add, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          if (suggestions.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      // Update the correct field (Pickup or Drop)
                      if (isPickup) {
                        pickupController.text = suggestion; // For Pickup City
                      } else {
                        dropController.text = suggestion; // For Drop City
                      }
                      ref
                          .read(isPickup
                              ? pickupSuggestionsProvider.notifier
                              : dropSuggestionsProvider.notifier)
                          .fetchSuggestions(''); // Clear suggestions
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/logo.png",
          height: 74,
        ),
        Icon(
          Icons.notifications,
          size: 30,
          color: Colors.white,
        )
      ],
    );
  }

  Widget _buildHeadingText() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'India’s Leading ', // White part
            style: TextStyle(
              fontFamily: 'Poppins', // Custom font name
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: 'Inter-City\nOne Way', // Green part
            style: TextStyle(
              fontFamily: 'Poppins', // Custom font name
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' Cab Service Provider', // White part
            style: TextStyle(
              fontFamily: 'Poppins', // Custom font name
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget _buildTripTypeTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTripTypeTab('assets/map.png', 'Outstation Trip', 0),
        _buildTripTypeTab('assets/localtrain.png', 'Local Trip', 1),
        _buildTripTypeTab('assets/transfer.png', 'Airport Transfer', 2),
      ],
    );
  }

  Widget _buildTripTypeTab(String imagePath, String title, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTripType = index;
          // Reset sub-tabs when switching between main tabs
          if (index != 0) selectedOutstationType = 0;
          if (index != 2) selectedAirportType = 0;
        });
      },
      child: Container(
        width: width * 0.3,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: selectedTripType == index ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(width * 0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              imagePath,
              width: width * 0.1,
              color: selectedTripType == index ? Colors.white : Colors.black,
            ),
            SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins', // Custom font name
                color: selectedTripType == index ? Colors.white : Colors.black,
                fontSize: height * 0.012,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutstationTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSubTab('One-Way', 0, true),
        _buildSubTab('Round Trip', 1, true),
      ],
    );
  }

  Widget _buildSubTab(String title, int index, bool isOutstation) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isOutstation)
            selectedOutstationType = index;
          else
            selectedAirportType = index;
        });
      },
      child: Container(
        width: width * 0.45,
        padding: EdgeInsets.symmetric(
            vertical: height * 0.005, horizontal: width * 0.05),
        decoration: BoxDecoration(
          color: selectedOutstationType == index ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            color:
                selectedOutstationType == index ? Colors.white : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicForm() {
    if (selectedTripType == 0) {
      // Outstation Trip
      return selectedOutstationType == 0
          ? _buildOutstationOneWayForm()
          : _buildOutstationRoundTripForm();
    } else if (selectedTripType == 1) {
      // Local Trip
      return _buildLocalTripForm();
    } else if (selectedTripType == 2) {
      // Airport Transfer
      return Column(
        children: [
          _buildAirportSubTabs(), // Add sub-tabs for airport transfer
          SizedBox(height: 16),
          selectedAirportType == 0
              ? _buildToAirportForm()
              : _buildFromAirportForm(),
        ],
      );
    }
    return Container(); // Default empty container
  }

  Widget _space() {
    return SizedBox(
      height: 13,
    );
  }

  Widget _buildOutstationOneWayForm() {
    return Container(
      padding: EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // White container background
        borderRadius:
            BorderRadius.circular(20), // Round corners for the container
      ),
      child: Column(
        children: [
          _buildFormFieldWithAutocomplete(
              'Pickup City', 'assets/pick.png', pickupController, true),
          _space(),
          _buildFormFieldWithAutocomplete(
              'Drop City', 'assets/drop.png', dropController, false),
          _space(),
          _buildDatePicker('Pickup Date', dateController,
              showImage: true, imagePath: 'assets/date.png'), // Show image
          _space(),
          _buildTimePicker('Time', timeController),
          _space(),
          _space(),
          _buildCustomButton(onPressed: () {
            // Action specific to this form
            print("Outstation One-Way form button pressed");
          }),
        ],
      ),
    );
  }

  Widget _buildOutstationRoundTripForm() {
    return Container(
      padding: EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // White container background
        borderRadius:
            BorderRadius.circular(20), // Round corners for the container
      ),
      child: Column(
        children: [
          _buildFormFieldWithAutocomplete(
              'Pickup City', 'assets/pick.png', pickupController, true),
          _space(),
          _buildFormFieldWithAutocomplete(
              'Destination City', 'assets/drop.png', dropController, false),
          _space(),

          _buildTimePicker(
              'Pickup Time', timeController), // Custom Time Picker with Image
          _space(), _space(),
          _buildCustomRoundTripDatePicker(),

          _space(), _space(),
          _buildCustomButton(onPressed: () {
            // Action specific to this form
            print("Outstation Round-Trip form button pressed");
          }),
        ],
      ),
    );
  }

  Widget _buildLocalTripForm() {
    return Container(
      padding: EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // White container background
        borderRadius:
            BorderRadius.circular(20), // Round corners for the container
      ),
      child: Column(
        children: [
          _buildFormFieldWithAutocomplete(
              'Pickup City', 'assets/pick.png', pickupController, true),
          _space(),
          _buildDatePicker('Pickup Date', dateController,
              showImage: true,
              imagePath: 'assets/date.png'), // Show image for Pickup Date
          _space(),
          _buildTimePicker('Pickup Time', timeController), // Time picker
          _space(), _space(),
          _buildCustomButton(onPressed: () {
            // Action specific to this form
            print("Local Trip form button pressed");
          }),
        ],
      ),
    );
  }

  Widget _buildToAirportForm() {
    return Container(
      padding: EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // White container background
        borderRadius:
            BorderRadius.circular(20), // Round corners for the container
      ),
      child: Column(
        children: [
          _buildFormFieldWithAutocomplete(
              'Pickup City', 'assets/pick.png', pickupController, true),
          _space(),
          _buildDatePicker('Pickup Date', dateController,
              showImage: true,
              imagePath: 'assets/date.png'), // Show image for Pickup Date
          _space(),
          _buildTimePicker('Pickup Time', timeController),
          _space(), _space(),
          _buildCustomButton(onPressed: () {
            // Action specific to this form
            print("To Airport form button pressed");
          }),
        ],
      ),
    );
  }

  Widget _buildFromAirportForm() {
    return Container(
      padding: EdgeInsets.all(16), // Padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // White container background
        borderRadius:
            BorderRadius.circular(20), // Round corners for the container
      ),
      child: Column(
        children: [
          _buildFormFieldWithAutocomplete(
              'Drop City', 'assets/drop.png', dropController, false),
          _space(),
          _buildDatePicker('Pickup Date', dateController,
              showImage: true,
              imagePath: 'assets/date.png'), // Show image for Pickup Date
          _space(),
          _buildTimePicker('Pickup Time', timeController),
          _space(), _space(),
          _buildCustomButton(onPressed: () {
            // Action specific to this form
            print("From Airport form button pressed");
          }),
        ],
      ),
    );
  }

  Widget _buildDatePicker(String label, TextEditingController controller,
      {bool showImage = false, String? imagePath}) {
    double height = 58.0; // Fixed height for the picker

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000), // Shadow color with 15% opacity
            offset: Offset(0, 4), // Vertical shadow offset
            blurRadius: 4, // Blur radius
          ),
        ],
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: GestureDetector(
        onTap: () {
          _selectDate(context, controller); // Show the date picker
        },
        child: AbsorbPointer(
          child: Container(
            height: height, // Fixed height
            decoration: BoxDecoration(
              color: Color(0xFFD5F2C8), // Background color #D5F2C8
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Row(
              children: [
                if (showImage && imagePath != null)
                  Padding(
                    padding: EdgeInsets.all(8.0), // Padding around the image
                    child: Image.asset(
                      imagePath, // Custom date picker image
                      height: 30, // Custom image height
                      width: 30, // Custom image width
                    ),
                  ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: label,
                      border: InputBorder.none, // Remove border
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior
                          .never, // Prevent label from floating
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Function to show Date Picker
  void _selectDate(BuildContext context, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 300, // Adjust height as per your requirement
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date, // Date mode
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              // Update the text field with the selected date
              setState(() {
                controller.text =
                    "${newDate.day}/${newDate.month}/${newDate.year}";
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildTimePicker(String label, TextEditingController controller) {
    double height = 58.0; // Fixed height for the picker

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000), // Shadow color with 15% opacity
            offset: Offset(0, 4), // Vertical shadow offset
            blurRadius: 4, // Blur radius
          ),
        ],
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: GestureDetector(
        onTap: () {
          _selectTime(context, controller); // Show the time picker
        },
        child: AbsorbPointer(
          child: Container(
            height: height, // Fixed height
            decoration: BoxDecoration(
              color: Color(0xFFD5F2C8), // Background color #D5F2C8
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Ensure row alignment
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0), // Padding around the image
                  child: Image.asset(
                    'assets/time.png', // Custom time picker image
                    height: 30, // Custom image height
                    width: 30, // Custom image width
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    textAlignVertical:
                        TextAlignVertical.center, // Ensures text stays centered
                    decoration: InputDecoration(
                      labelText: label,
                      border: InputBorder.none, // Remove border
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 24), // Center text vertically
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior
                          .never, // Prevent label from floating
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Function to show Time Picker
  void _selectTime(BuildContext context, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 300, // Adjust height as per your requirement
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time, // Time mode
            initialDateTime:
                DateTime(0, 0, 0, TimeOfDay.now().hour, TimeOfDay.now().minute),
            onDateTimeChanged: (DateTime newTime) {
              final time =
                  TimeOfDay(hour: newTime.hour, minute: newTime.minute);
              // Update the text field with the selected time
              setState(() {
                controller.text = time.format(context); // Format time as HH:mm
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildCustomButton({required VoidCallback onPressed}) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.5,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          'Explore Cabs',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Function to select date for From Date
  void _selectFromDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        fromDateController.text =
            "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  // Function to select date for To Date
  void _selectToDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        toDateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  // Function to build the row with From Date and To Date
  Widget _buildCustomRoundTripDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // From Date Column
        Column(
          children: [
            Text(
              "From Date",
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            GestureDetector(
              onTap: () => _selectFromDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  fromDateController.text.isEmpty
                      ? "DD-MM-YYYY" // Placeholder
                      : fromDateController.text, // Selected date
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 8,
        ), // Space between From Date and image

        // Middle Image
        Image.asset(
          'assets/date1.png',
          height: 50,
          width: 50,
        ),
        SizedBox(
          width: 8,
        ), // Space between image and To Date

        // To Date Column
        Column(
          children: [
            Text(
              "To Date",
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            GestureDetector(
              onTap: () => _selectToDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  toDateController.text.isEmpty
                      ? "DD-MM-YYYY" // Placeholder
                      : toDateController.text, // Selected date
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

//-----------------------
}
