import io
import base64
from PIL import Image, ImageGrab
import pyperclip  # 确保已经安装了pyperclip库

def get_image_base64_from_clipboard():
    """
    从剪贴板获取图片，并将其转换为Base64编码的字符串。
    如果剪贴板中没有图片，返回None。
    """
    # 从剪贴板获取图片
    im = ImageGrab.grabclipboard()

    # 检查剪贴板中的内容是否为图片
    if isinstance(im, Image.Image):
        print("Image: size: %s, mode: %s" % (im.size, im.mode))
        # 将图片转换为Base64编码
        buffered = io.BytesIO()
        im.save(buffered, format="PNG")
        img_base64 = base64.b64encode(buffered.getvalue()).decode('utf-8')
        # 返回Base64编码的完整字符串
        return img_base64
    else:
        return "no image"

# 如果这个模块被直接运行，执行以下代码
if __name__ == "__main__":
    base64_str = get_image_base64_from_clipboard()
    if base64_str:
        # 打印Base64编码的前500个字符
        res = f'<img src="data:image/png;base64,{base64_str}" />'
        pyperclip.copy(res)

    else:
        pass