# 安裝並載入必要套件
#install.packages("readr")
#install.packages("ggplot2")
library(readr)
library(ggplot2)

# 讀取 CSV 檔案，嘗試 Big5 編碼
my_data <- read_csv("./2-38_桃園市社會工作人員專職人員.csv", locale = locale(encoding = "UTF-8"))

# 檢查資料結構
str(my_data)
head(my_data)

# 檢查欄位名稱是否正確
names(my_data)

# 假設資料框中有兩個欄位，修改欄位名稱
names(my_data) <- c("年度", "男性", "女性")
my_data$專職人員總數 <- my_data$男性 + my_data$女性

# 檢查欄位名稱是否正確
names(my_data)

# 移除缺失值（如有需要）
my_data <- na.omit(my_data)

# 檢查專職人員總數是否是數字型別，若不是，請轉換
#my_data$專職人員總數 <- as.numeric(my_data$專職人員總數)

# 繪製長條圖，使用雙 Y 軸
ggplot(my_data) +
  # 繪製男性和女性的長條圖
  geom_bar(aes(x = 年度, y = 男性), stat = "identity", fill = "steelblue", alpha = 0.7) +
  geom_bar(aes(x = 年度, y = 女性), stat = "identity", fill = "lightcoral", alpha = 0.7) +
  # 創建第二個 Y 軸顯示專職人員總數
  geom_line(aes(x = 年度, y = 專職人員總數 ), color = "darkgreen", size = 1) +  # 放大專職人員數字使其顯示在副軸上
  scale_y_continuous(
    name = "男性 / 女性人數", 
    sec.axis = sec_axis(~ . / 10, name = "專職人員總數")  # 第二個 Y 軸需要進行反向縮放
  ) +
  labs(
    title = "桃園市社會工作人員專職人員數量 (男性、女性與總數)",
    x = "年度"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 保存圖表為 PNG 檔案
ggsave("雙Y軸_專職人員長條圖.png", width = 8, height = 6)


