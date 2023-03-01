import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? suffixPressed,
  void Function()? onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type, //phone in case of numbers field
      obscureText: isPassword,
      onFieldSubmitted:
          onSubmit, //to catch the value after pressing the correct mark on keyboard
      onChanged: onChange, //catches the value with every single input
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );


Widget defaultTextButton({
  required Function function,
  required String text
}) => TextButton(
    onPressed: function(),
    child: Text(text),
);

/*Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteFromDatabase(id:model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
            ),
          ),

        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text
                (
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateDatabase(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            )
        ),
        IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateDatabase(status: 'archived', id: model['id']);
            },
            icon: Icon(
              Icons.archive,
              color: Colors.black45,
            )
        ),
      ],
    ),
  ),
);


Widget taskConditionalBuilder({
  required List<Map> tasks
}) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index) => separator(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_to_queue_rounded,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'You haven\'t added any tasks yet',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);*/

Widget separator() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        height: 1.0,
        color: Colors.grey[300],
        width: double.infinity,
      ),
    );

Widget buildNewsItem(article, context) => InkWell(
      onTap: () {
        //navigateTo(context /*WebViewScreen(articleURL: article['url']*/));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildNewsArticles(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            buildNewsItem(list[index], context),
        separatorBuilder: (BuildContext context, int index) => separator(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );



void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));



void navigateToReplace(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);
