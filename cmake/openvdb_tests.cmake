#
#
#

SET ( UNITTEST_SOURCE_FILES
	unittest/main.cc
	unittest/TestAttributeArray.cc
	unittest/TestAttributeArrayString.cc
	unittest/TestAttributeGroup.cc
	unittest/TestAttributeSet.cc
	unittest/TestBBox.cc
	unittest/TestConjGradient.cc
	unittest/TestCoord.cc
	unittest/TestCpt.cc
	unittest/TestCurl.cc
	unittest/TestDense.cc
	unittest/TestDenseSparseTools.cc
	unittest/TestDiagnostics.cc
	unittest/TestDivergence.cc
	unittest/TestDoubleMetadata.cc
	unittest/TestExceptions.cc
	unittest/TestFile.cc
	unittest/TestFloatMetadata.cc
	unittest/TestGradient.cc
	unittest/TestGrid.cc
	unittest/TestGridBbox.cc
	unittest/TestGridDescriptor.cc
	unittest/TestGridIO.cc
	unittest/TestGridTransformer.cc
	unittest/TestIndexFilter.cc
	unittest/TestIndexIterator.cc
	unittest/TestInit.cc
	unittest/TestInt32Metadata.cc
	unittest/TestInt64Metadata.cc
	unittest/TestInternalOrigin.cc
	unittest/TestLaplacian.cc
	unittest/TestLeaf.cc
	unittest/TestLeafBool.cc
	unittest/TestLeafManager.cc
	unittest/TestLeafMask.cc
	unittest/TestLeafIO.cc
	unittest/TestLeafOrigin.cc
	unittest/TestLevelSetRayIntersector.cc
	unittest/TestLevelSetUtil.cc
	unittest/TestLinearInterp.cc
	unittest/TestMaps.cc
	unittest/TestMat4Metadata.cc
	unittest/TestMath.cc
	unittest/TestMeanCurvature.cc
	unittest/TestMeshToVolume.cc
	unittest/TestMetadata.cc
	unittest/TestMetadataIO.cc
	unittest/TestMetaMap.cc
	unittest/TestMultiResGrid.cc
	unittest/TestName.cc
	unittest/TestNodeIterator.cc
	unittest/TestNodeManager.cc
	unittest/TestNodeMask.cc
	unittest/TestParticleAtlas.cc
	unittest/TestParticlesToLevelSet.cc
	unittest/TestPointAttribute.cc
	unittest/TestPointConversion.cc
	unittest/TestPointCount.cc
	unittest/TestPointDataLeaf.cc
	unittest/TestPointGroup.cc
	unittest/TestPointIndexGrid.cc
	unittest/TestPointPartitioner.cc
	unittest/TestPointsToMask.cc
	unittest/TestPoissonSolver.cc
	unittest/TestPrePostAPI.cc
	unittest/TestQuadraticInterp.cc
	unittest/TestQuantizedUnitVec.cc
	unittest/TestQuat.cc
	unittest/TestRay.cc
	unittest/TestStats.cc
	unittest/TestStream.cc
	unittest/TestStreamCompression.cc
	unittest/TestStringMetadata.cc
	unittest/TestTools.cc
	unittest/TestTopologyToLevelSet.cc
	unittest/TestTransform.cc
	unittest/TestTree.cc
	unittest/TestTreeCombine.cc
	unittest/TestTreeGetSetValues.cc
	unittest/TestTreeIterators.cc
	unittest/TestTreeVisitor.cc
	unittest/TestUtil.cc
	unittest/TestValueAccessor.cc
	unittest/TestVec2Metadata.cc
	unittest/TestVec3Metadata.cc
	unittest/TestVolumeRayIntersector.cc
	unittest/TestVolumeToMesh.cc
	)

SET_SOURCE_FILES_PROPERTIES ( ${UNITTEST_SOURCE_FILES}
  PROPERTIES
  COMPILE_FLAGS "-DOPENVDB_USE_BLOSC"
  )

IF ( OPENVDB_BUILD_UNITTESTS )

  ADD_EXECUTABLE ( vdb_test
  ${UNITTEST_SOURCE_FILES}
  )

TARGET_LINK_LIBRARIES ( vdb_test
	${CPPUnit_cppunit_LIBRARY}
	openvdb_static
	${BLOSC_blosc_LIBRARY}
	)

  ADD_TEST ( vdb_unit_test vdb_test )

ENDIF (OPENVDB_BUILD_UNITTESTS)