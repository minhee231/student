package egovframework.saa.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class UniqueId {
    public static String generateUniqueId() {
        Random random = new Random();
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        int randomNumber = random.nextInt(1000);
        String formattedRandomNumber = String.format("%03d", randomNumber);

        return currentTime + formattedRandomNumber;
    }
}
