package glm.detail

import std.fs.*
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testZeroVecCommentPresent(): Unit {
    let path = Path("tests/glm/detail/test_vec_mat_mul.cj")
    let raw = String.fromUtf8(File.readFrom(path))
    let content = raw.replaceAll("\r\n", "\n")
    let expected = "/**\n * ZeroVec 测试评估结论（T18）：\n * 保留全部 9 个 ZeroVec 测试，理由：\n * 1. 维护成本极低（与基础测试共享展开公式，仅输入向量值不同）\n * 2. 每个矩阵类型（2x2~4x4）均有独立验证价值\n * 3. 零向量×任意矩阵=零矩阵，该恒等式需逐矩阵类型验证\n */\n// === Boundary: Zero Vector ==="
    @Expect(content.contains(expected), true)
}

@Test
func testZeroVecCommentBeforeBoundaryMarker(): Unit {
    let path = Path("tests/glm/detail/test_vec_mat_mul.cj")
    let content = String.fromUtf8(File.readFrom(path))
    let boundaryIdx = content.indexOf("// === Boundary: Zero Vector ===")
    let commentIdx = content.indexOf("ZeroVec 测试评估结论")
    @Expect(commentIdx >= 0, true)
    @Expect(boundaryIdx >= 0, true)
    @Expect(commentIdx < boundaryIdx, true)
}
