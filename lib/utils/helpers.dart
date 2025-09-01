
// İlk harfi büyük yapar
String capitalize(String text) {
	if (text.isEmpty) return text;
	return text[0].toUpperCase() + text.substring(1);
}

// Tarihi kısa formatta döndürür (gg.aa.yyyy)
String formatShortDate(DateTime date) {
	return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
}
