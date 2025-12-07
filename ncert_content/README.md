# NCERT Content Directory

## PDF Naming Convention

Place your NCERT PDF files in the `pdfs/` subdirectory with the following naming format:

```
Subject_Class_ChapterNumber.pdf
```

### Examples:
- `Physics_12_01.pdf` - Physics Class 12, Chapter 1
- `Chemistry_11_05.pdf` - Chemistry Class 11, Chapter 5
- `Mathematics_12_10.pdf` - Mathematics Class 12, Chapter 10
- `Biology_11_03.pdf` - Biology Class 11, Chapter 3

## Supported Subjects:
- Physics
- Chemistry
- Mathematics
- Biology

## Supported Classes:
- 11 (Class 11)
- 12 (Class 12)

## Processing Steps:

1. **Add PDFs**: Place your NCERT PDF files in the `pdfs/` directory following the naming convention
2. **Run Processor**: Execute `python setup_ncert_pipeline.py` to process all PDFs
3. **Verify**: The script will create a vector store in the `vector_store/` directory

## What Gets Created:

- **Text Chunks**: Each PDF is split into ~500-word chunks with 50-word overlap
- **Embeddings**: Each chunk is converted to a vector embedding using sentence-transformers
- **Vector Store**: All embeddings are stored in ChromaDB for fast semantic search
- **Metadata**: Each chunk includes subject, class, chapter, and page number information

## Notes:

- Processing time depends on the number and size of PDFs
- The vector store will be created in the parent `vector_store/` directory
- You can re-run the processor to add new PDFs (existing ones will be skipped if already processed)
- Ensure PDFs are text-based (not scanned images) for best results

## Troubleshooting:

- **No text extracted**: Ensure PDFs contain selectable text, not just images
- **Slow processing**: This is normal for large PDFs; be patient
- **Memory errors**: Try processing fewer PDFs at a time
