#!/usr/bin/env python3
"""Generate src/fwd.cj with GLM-compatible type aliases."""
import os

SCALAR_MAP = {
    'int8': 'Int8', 'int16': 'Int16', 'int32': 'Int32', 'int64': 'Int64',
    'uint8': 'UInt8', 'uint16': 'UInt16', 'uint32': 'UInt32', 'uint64': 'UInt64',
    'float': 'Float32', 'double': 'Float64',
    'uint': 'UInt32',
}
SCALAR_PRECISIONS = [('', ''), ('highp_', ''), ('mediump_', ''), ('lowp_', '')]

VEC_FAMILIES = {
    'B': 'Bool', 'I': 'Int32', 'U': 'UInt32', 'Vec': 'Float32',
    'DVec': 'Float64', 'I8': 'Int8', 'I16': 'Int16', 'I32': 'Int32',
    'I64': 'Int64', 'U8': 'UInt8', 'U16': 'UInt16', 'U32': 'UInt32',
    'U64': 'UInt64', 'FVec': 'Float32', 'F32': 'Float32', 'F64': 'Float64',
}
VEC_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                  ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
DIMS = [1, 2, 3, 4]
VEC_TYPES = {1: 'Vec1', 2: 'Vec2', 3: 'Vec3', 4: 'Vec4'}

OUTPUT = 'src/fwd.cj'


def main():
    lines = [
        '// fwd.cj — GLM 兼容类型别名（自动生成）',
        '// 注意：此文件由脚本自动生成，手动修改请谨慎',
        'package glm',
        '',
    ]
    lines.append('import glm.detail')
    lines.append('import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }')
    lines.append('')

    for prefix, _ in SCALAR_PRECISIONS:
        for name, canon in SCALAR_MAP.items():
            lines.append(f'public type {prefix}{name} = {canon}')
    lines.append('')

    for family_name, family_type in VEC_FAMILIES.items():
        lines.append(f'// === {family_name} family ===')
        for prec_prefix, prec_type in VEC_PRECISIONS:
            for dim in DIMS:
                vec_type = VEC_TYPES[dim]
                suffix = '' if family_name.endswith('Vec') else 'Vec'
                alias_name = f'{prec_prefix}{family_name}{suffix}{dim}'
                lines.append(f'public type {alias_name} = detail.{vec_type}<{family_type}, {prec_type}>')
    lines.append('')

    # === Quat family (FQuat is Float32 default-precision only, same as Quat) ===
    QUAT_BASE = {'Quat': 'Float32', 'DQuat': 'Float64'}
    QUAT_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                       ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
    lines.append('// === Quat family ===')
    for prec_prefix, prec_type in QUAT_PRECISIONS:
        for family_name, family_type in QUAT_BASE.items():
            alias_name = f'{prec_prefix}{family_name}'
            lines.append(f'public type {alias_name} = detail.Quat<{family_type}, {prec_type}>')
    # FQuat = Quat (Float32), default precision only — no precision prefix variants
    lines.append(f'public type FQuat = detail.Quat<Float32, PackedHighp>')
    lines.append('')

    content = '\n'.join(lines)
    script_dir = os.path.dirname(os.path.abspath(__file__))
    output_path = os.path.join(script_dir, '..', OUTPUT)
    output_path = os.path.normpath(output_path)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    newline = '\n'
    if os.path.exists(output_path):
        try:
            with open(output_path, 'rb') as f:
                existing = f.read()
            if b'\r\n' in existing:
                newline = '\r\n'
        except Exception:
            pass
    with open(output_path, 'w', encoding='utf-8', newline=newline) as f:
        f.write(content)
    print(f'Generated {output_path}')


if __name__ == '__main__':
    main()
