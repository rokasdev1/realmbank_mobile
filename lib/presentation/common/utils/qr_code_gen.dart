String qrCodeGen({
  required String requestorCardNum,
  required double amount,
  required String description,
}) {
  // requesterCardNum to amount for description(Request)
  return 'REQUEST-MONEY $requestorCardNum:$amount:$description(Request)';
}
