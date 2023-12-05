


import 'dart:io';

void main()
{
  // justSomething();
  justSomething2();
}
// Example of the synchoronour actions
void justSomething() {
  task1();
  task2();
  task3();
}
   void task1()
  {
    print('task 1 complete');
  }
   void task2()
  {
    // Until this this function gets completed the task 3 will not get executed
    Duration time = const Duration(seconds: 4);
    sleep(time);
    print('task 2 complete');
  }
  void task3()
  {
    print('task 3 complete');
  }
//Example of asynchronous actions
void justSomething2() {
  task4();
  task5();
  task6();
}
void task4()
{

  print('task 4 complete');
}
Future<String> task5 () async
{
  Duration seconds = const Duration(seconds: 3);
   late String result;
  await Future.delayed(seconds,() {
     result = 'task 5 data';
    print('task 5 complete');
    }
  );
  return result;
  }

void task6()
{
  print('task 6 completed');
}

