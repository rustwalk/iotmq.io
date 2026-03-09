+++
title = "test文档V1.0"
+++

这是一段用于测试 **Tailwind Typography**（即 `prose` 类名）渲染效果的实战文档。如果你看到了优美的行高、合适的字号和漂亮的间距，说明你的
CSS 插件已经大功告成！🎉

## 1. 标题层级与间距测试

在模板设计中，我们通常将 `H1` 留给页面的大标题。这里是二级标题（H2），用来划分核心章节。

### 1.1 三级标题测试 (H3)

这里是三级标题，通常用于划分模块内的小节。排版插件会自动处理标题之间的上下边距（Margin），让阅读充满呼吸感，不会显得文字挤在一起。

#### 1.1.1 四级标题测试 (H4)

四级标题通常字体稍小，用于更细致的要点罗列。

---

## 2. 文本修饰与超链接

这是普通的正文段落。你可以使用 **粗体** 来强调核心观点，或者使用 *斜体* 表示专有名词，甚至使用 ~~删除线~~ 标记已经废弃的旧版本特性。

如果需要引用外部资源，可以插入 [IoTMQ GitHub 仓库](https://github.com/rustwalk/iotmq) 这样的超链接。当我们在文本中提及某个变量、函数或文件名时，比如
`config.toml` 或 `MAX_CONNECTIONS`，内联代码块应该有稍微不同的背景色或字体，以区分于普通纯文本。

## 3. 列表展示

在技术文档中，列表是使用频率最高的元素之一。

### 无序列表与嵌套

IoTMQ 的核心设计目标包括：

* 🚀 **极致性能**：基于 Rust 的异步运行时构建。
* 🛡️ **内存安全**：从根源上告别传统 C/C++ 中的段错误和内存泄漏。
* 🔌 **多协议与多端支持**：
    * MQTT v3.1.1 / v5.0 核心协议
    * WebSocket 实时网关
    * HTTP REST API 管理接口

### 有序列表

本地快速启动步骤：

1. 下载对应操作系统（macOS / Linux）的预编译程序。
2. 复制 `config.example.toml` 并重命名为 `config.toml`，修改其中的网络接口配置。
3. 在终端运行 `./iotmq start` 命令启动服务。
4. 观察控制台输出，确认服务已监听在 `1883` 端口。

## 4. 引用块 (Blockquote)

在撰写说明文档时，我们经常需要添加警告或高亮提示信息：

> **💡 生产环境最佳实践**
>
> 建议在部署生产环境时，将日志级别设置为 `WARN` 或 `ERROR`，以获得最佳的并发吞吐量表现。开启全量的 `DEBUG` 或 `TRACE`
> 日志会占用大量的磁盘 I/O，可能导致消息延迟。

## 5. 核心：代码高亮测试

Zola 极其强大的一点是，它不需要你在前端引入类似 `Prism.js` 的脚本，它在编译 HTML 时就已经把代码高亮的颜色算好了！

```rust
// src/network/server.rs
use tokio::net::TcpListener;
use tracing::{info, error};

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 初始化 MQTT 监听端口
    let listener = TcpListener::bind("0.0.0.0:1883").await?;
    info!("🚀 IoTMQ Server is running on port 1883");
    
    loop {
        match listener.accept().await {
            Ok((socket, addr)) => {
                info!("New connection from: {}", addr);
                // 派发新的异步任务处理连接
                tokio::spawn(async move {
                    process_connection(socket).await;
                });
            }
            Err(e) => error!("Failed to accept connection: {}", e),
        }
    }
}