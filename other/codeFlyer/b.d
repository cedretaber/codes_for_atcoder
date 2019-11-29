import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto abn = readln.split.to!(int[]);
    auto A = abn[0];
    auto B = abn[1];
    foreach (x; readln.chomp.to!(wchar[])) switch (x)
    {
    case 'S':
        --A;
        break;
    case 'C':
        --B;
        break;
    default:
        if (B > A)
        {
            --B;
        }
        else
        {
            --A;
        }
    }
    writeln(max(A, 0));
    writeln(max(B, 0));
}
