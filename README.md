# Claude Code + FreeLLMAPI (Windows)

Chạy Claude Code qua FreeLLMAPI, một server chạy trên máy bạn, gom các gói miễn phí của nhiều nhà cung cấp (Groq, Google, NVIDIA, OpenRouter...) về một địa chỉ duy nhất.

## Cách hoạt động

```
Claude Code  -->  FreeLLMAPI (localhost:3001)  -->  Groq / Google / NVIDIA / ...
                  Dashboard (localhost:5173)
```

| Thành phần | Địa chỉ / vị trí | Vai trò |
|---|---|---|
| API | `http://localhost:3001` | Claude Code gọi vào đây |
| Dashboard | `http://localhost:5173` | Quản lý key, xem model |
| Unified key | Trang **Keys**, bắt đầu bằng `freellmapi-` | Chìa khoá để vào FreeLLMAPI |
| Provider key | Key của Groq, Google... | Phải thêm vào dashboard |

## Yêu cầu

- Windows, Node.js 20+ và npm
- Claude Code đã cài (gõ `claude` chạy được)
- Thư mục FreeLLMAPI đã chạy `npm install` và có file `.env` chứa `ENCRYPTION_KEY`
- Ít nhất một key nhà cung cấp (ví dụ Groq) đã thêm vào dashboard

## Dùng nhanh

1. Double-click `claude-free.bat`: tự bật server nếu chưa chạy, rồi mở Claude Code.
2. Cần mở dashboard thì double-click `mo-web-freellmapi.bat`.

Giữ cửa sổ **FreeLLMAPI Server** mở trong lúc dùng. Đóng nó là server tắt.

## Cài đặt lần đầu

1. Bật server:

   ```
   cd /d C:\Users\thitm\freellmapi
   npm run dev
   ```

2. Mở dashboard: `start http://localhost:5173`
3. Trang **Keys**: copy unified key, thêm key nhà cung cấp (Groq...).
4. Mở `claude-free.bat` bằng Notepad (chuột phải, Edit), sửa dòng sau cho đúng key của bạn:

   ```
   set ANTHROPIC_AUTH_TOKEN=freellmapi-KEY-CUA-BAN
   ```

5. Double-click `claude-free.bat`, gõ `xin chao` để thử.

Nếu đường dẫn máy bạn khác, sửa hai dòng đầu của file `.bat`: `FREELLM_DIR` (thư mục FreeLLMAPI) và `PROJECT_DIR` (thư mục dự án).

## Kiểm tra server bằng curl (tuỳ chọn)

```
curl http://127.0.0.1:3001/v1/messages -H "x-api-key: UNIFIED_KEY" -H "anthropic-version: 2023-06-01" -H "content-type: application/json" -d "{\"model\":\"TEN_MODEL\",\"max_tokens\":50,\"messages\":[{\"role\":\"user\",\"content\":\"hi\"}]}"
```

Giữ nguyên chữ `x-api-key:`, key chỉ nằm sau dấu hai chấm.

## Lỗi thường gặp

| Triệu chứng | Nguyên nhân | Cách sửa |
|---|---|---|
| `ERR_CONNECTION_REFUSED` khi mở dashboard | Server đang tắt | Chạy `npm run dev` hoặc `mo-web-freellmapi.bat` |
| `401 Invalid API key` | Unified key không khớp server đang chạy | Copy lại key ở trang **Keys**, sửa trong file `.bat`, mở cmd mới |
| `no_providers_configured` | Chưa thêm key nhà cung cấp | Thêm key Groq... ở trang **Keys** |
| `Not logged in · Please run /login` | Claude Code không đọc được cấu hình | Dùng `claude-free.bat`, đừng chạy `/login` |
| `npm error ENOENT package.json` | Đang đứng sai thư mục (ví dụ `System32`) | `cd` vào thư mục FreeLLMAPI trước |
| `The filename, directory name... is incorrect` | Dùng cú pháp PowerShell trong cmd | Trong cmd dùng `set TEN=gia_tri` |
| `EADDRINUSE` | Cổng 3001 đã bị chiếm | `netstat -ano \| findstr :3001`, rồi `taskkill /PID SO_CUOI /F` |
| Không dán được vào cmd | Cài đặt cmd | Dán trong Notepad và lưu thành `.bat` (chọn **All files** khi Save as) |
| Dòng đầu vẫn hiện `Opus 5.5` | Cấu hình chưa áp dụng | Mở cmd mới, chạy lại bằng `.bat`, hoặc gõ `/model` |

## Lưu ý

- Máy có thể có nhiều bản FreeLLMAPI (hai thư mục và app Desktop). Mỗi bản có unified key và provider key riêng.
- Unified key chỉ dùng cho server trên máy bạn, nhưng đừng đăng công khai. Nếu lộ, tạo lại key trong dashboard rồi sửa lại file `.bat`.
- Các gói miễn phí có giới hạn tốc độ. Model nào báo hết hạn mức thì chọn model khác hoặc thêm key nhà cung cấp khác.
