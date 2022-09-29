## WangShuang_Assembly
王爽《汇编语言》的相关代码

## 让 DosBox 自动执行一些命令
### 需求
从 `asm` 源文件到 `exe` 可执行文件需要经过 `masm fileName.asm` 和 `link fileName.obj` 两步。而且有时候还要多次修改源文件，那就要多次汇编、链接。
然而我不想敲命令，也不想敲文件名。那能不能让软件自动地完成这些工作呢？
还有，我希望 `masm fileName.asm` 和 `link fileName.obj` 执行后，删除生成的 `obj` 文件，再把生成的 `exe` 可执行文件放到另一个文件夹中。


### 解决方案
在 DoxBox 的安装目录（我这里是 `D:\Program Files (x86)\DOSBox-0.74`）下有一个名为 `DOSBox 0.74 Options.bat` 的文件。
双击该文件，会打开一个名为 `DOSBox-0.74.conf` 的文件。在该文件的末尾添加 Dos 命令，DosBox 会在启动后自动执行。

**准备工作**

在 `D:` 创建 `ASM` 文件夹，这里将存放 `asm` 源文件。在 `D:\ASM` 下创建 `exe` 文件夹，存放 `exe` 可执行文件。
把解压出的 `debug.exe masm.exe link.exe` 三个文件复制到 `D:\ASM` 文件夹下。



**添加命令**

我在 `DOSBox-0.74.conf` 添加了以下命令。

```
# 将目录D:\ASM挂载为DOSBOX下的C:
MOUNT C D:\ASM
# 打开 c:
c:

# 此时 D:\ASM 下有  `debug.exe masm.exe link.exe` 三个文件
# 把需要汇编、链接的源文件加入
masm 9_1;
link 9_1;

masm 9_2;
link 9_2;

masm 15_1;
link 15_1;


masm 16_1;
link 16_1;

masm Lab16;
link Lab16;



# 参数/-Y：覆盖 exe 文件夹中的同名文件
copy *.exe \exe /-Y
# 删除
del *.exe
del *.obj

cd \exe
# 前面把 D:\ASM 里的 exe 文件删完了
# 也许你想手动汇编、链接
copy debug.exe .. /-Y
copy masm.exe .. /-Y
copy link.exe .. /-Y
```
