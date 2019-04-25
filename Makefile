autocorrect:
	@swiftlint autocorrect

documentation:
	@rm -rf ./Docs
	@jazzy -x -workspace,PCFSwift.xcworkspace,-scheme,PCFSwift \
						--clean \
            --min-acl internal \
            --no-hide-documentation-coverage \
            --theme fullwidth \
            --author "Prolific Interactive" \
					  --module PCFSwift \
            --output ./Docs
	@rm -rf ./build
