import '../../general_exports.dart';

class MadaDropdownList extends StatelessWidget {
  const MadaDropdownList({
    required this.label,
    required this.items,
    super.key,
    this.onChanged,
    this.valueKey = keyValue,
    this.textKey = 'key',
  });

  final String label;
  final List<dynamic> items;

  final ValueChanged<dynamic>? onChanged;
  final String valueKey;
  final String textKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DEVICE_HEIGHT * 0.01,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DEVICE_HEIGHT * 0.01,
              ),
              borderSide: const BorderSide(
                color: Color(AppColors.gray6),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DEVICE_HEIGHT * 0.01,
              ),
              borderSide: const BorderSide(
                color: Color(AppColors.gray6),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: DEVICE_WIDTH * 0.01,
              vertical: DEVICE_HEIGHT * 0.015,
            ),
          ),
          icon: SvgPicture.asset(
            iconSelectListArrow,
            height: DEVICE_HEIGHT * 0.05,
          ),
          hint: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(AppColors.gray2),
                ),
          ),
          dropdownColor: const Color(AppColors.white),
          items: items.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item[valueKey],
                child: Text(
                  item[textKey],
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              );
            },
          ).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
