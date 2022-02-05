import 'package:flutter/material.dart';
import '../../c/strict_column.dart';

// 关于: LICENSE 部分
class License extends StatelessWidget {
  const License({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StrictColumn(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: SelectableText(
            'LICENSE',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.lightGreen.shade100,
          child: const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: SelectableText(license),
          ),
        ),
      ],
    );
  }
}

const license = """\
a_pinyin: Open source Chinese pinyin input method
Copyright (C) 2022  sceext

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
""";
