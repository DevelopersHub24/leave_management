import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key});

  @override
  _ApplyPageState createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Set<DateTime> _selectedDates = {}; // For multiple date selection (Leave)

  void _selectOption(String option) {
    if (option == 'Leave') {
      _showLeavePopup();
    } else {
      _showCalendarPopup(option);
    }
  }

  void _showCalendarPopup(String option) {
    DateTime? selectedDate;
    TimeOfDay? outTime;
    TimeOfDay? inTime;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                'Apply for $option',
                style: const TextStyle(color: Colors.white),
              ),
              content: SizedBox(
                width: 300,
                height: 500,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // DATE SELECTION
                        Text("Select Date",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 400,
                          child: TableCalendar(
                            focusedDay: _focusedDay,
                            firstDay: DateTime.utc(2000, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            selectedDayPredicate: (day) =>
                                isSameDay(selectedDate, day),
                            onDaySelected: (selectedDay, focusedDay) {
                              setDialogState(() {
                                selectedDate = selectedDay;
                              });
                            },
                            calendarStyle: CalendarStyle(
                              selectedDecoration: BoxDecoration(
                                color: Colors.teal[400],
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: Colors.teal.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              defaultTextStyle: TextStyle(color: Colors.white),
                              weekendTextStyle: TextStyle(color: Colors.red),
                              outsideTextStyle: TextStyle(color: Colors.grey),
                            ),
                            headerStyle: HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                              titleTextStyle: TextStyle(color: Colors.white),
                              leftChevronIcon:
                                  Icon(Icons.chevron_left, color: Colors.white),
                              rightChevronIcon: Icon(Icons.chevron_right,
                                  color: Colors.white),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(color: Colors.white),
                              weekendStyle: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // OUT TIME PICKER
                        ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setDialogState(() {
                                outTime = pickedTime;
                              });
                            }
                          },
                          child: Text(
                            outTime == null
                                ? "Select Out Time"
                                : "Out Time: ${outTime!.format(context)}",
                          ),
                        ),
                        const SizedBox(height: 10),

                        // IN TIME PICKER
                        ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setDialogState(() {
                                inTime = pickedTime;
                              });
                            }
                          },
                          child: Text(
                            inTime == null
                                ? "Select In Time"
                                : "In Time: ${inTime!.format(context)}",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedDate == null ||
                        outTime == null ||
                        inTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select all required fields")),
                      );
                      return;
                    }

                    setState(() {
                      _selectedDay = selectedDate;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              '$option requested on $selectedDate, Out: ${outTime!.format(context)}, In: ${inTime!.format(context)}')),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Request',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLeavePopup() {
    Set<DateTime> tempSelectedDates =
        Set.from(_selectedDates); // Temporary variable for popup state

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              title: const Text(
                'Select Dates for Leave',
                style: TextStyle(color: Colors.white),
              ),
              content: SizedBox(
                width: 300, // Set a fixed width
                height: 400, // Set a fixed height
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) {
                    return tempSelectedDates.contains(day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setDialogState(() {
                      if (tempSelectedDates.contains(selectedDay)) {
                        tempSelectedDates.remove(selectedDay);
                      } else {
                        tempSelectedDates.add(selectedDay);
                      }
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.teal[400],
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: const TextStyle(
                      color: Colors.white, // Makes regular dates white
                      fontSize: 16, // Increase font size if needed
                    ),
                    weekendTextStyle: const TextStyle(
                      color: Colors.red, // Makes weekend dates red
                      fontSize: 16,
                    ),
                    outsideDaysVisible:
                        false, // Hide dates outside current month
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(color: Colors.white),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: const TextStyle(color: Colors.white),
                    weekendStyle: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedDates =
                          tempSelectedDates; // Update the main selected dates
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Leave requested for $_selectedDates')),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text('Request',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Apply'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centering the buttons
              children: [
                TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.teal[400],
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: const TextStyle(color: Colors.white),
                    weekendTextStyle: const TextStyle(color: Colors.red),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(color: Colors.white),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: const TextStyle(color: Colors.white),
                    weekendStyle: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Apply for:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => _selectOption('OnDuty'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: const Color(0xFFCFCACA),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                        50), // Making the button bigger
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'OnDuty',
                    style: TextStyle(
                        color: Colors.black), // Set text color to black
                  ),
                ),
                const SizedBox(height: 20), // Spacing between buttons
                ElevatedButton(
                  onPressed: () => _selectOption('Permission'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: const Color(0xFF6B6A69),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                        50), // Making the button bigger
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Permission',
                    style: TextStyle(
                        color: Colors.black), // Set text color to black
                  ),
                ),
                const SizedBox(height: 20), // Spacing between buttons
                ElevatedButton(
                  onPressed: () => _selectOption('Leave'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: const Color(0xFFE2333B),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                        50), // Making the button bigger
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Leave',
                    style: TextStyle(
                        color: Colors.black), // Set text color to black
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
